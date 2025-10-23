require 'rails_helper'

RSpec.describe ShoppingItem, type: :model do
  let(:shopping_list) { ShoppingList.create!(name: '買い物リスト') }

  describe '関連' do
    it '買い物リスト(shopping_list)に属すること' do
      item = ShoppingItem.new(name: 'テスト商品', position: 1)
      expect(item).to respond_to(:shopping_list)
    end

    it '買い物リストが必須であること' do
      item = ShoppingItem.new(name: 'テスト商品', position: 1)
      expect(item).not_to be_valid
    end
  end

  describe 'バリデーション' do
    it 'nameが必須であること' do
      item = shopping_list.items.build(name: nil, position: 1)
      expect(item).not_to be_valid
      expect(item.errors[:name]).to be_present
    end

    it 'nameがあれば有効であること' do
      item = shopping_list.items.build(name: 'テスト商品', position: 1)
      expect(item).to be_valid
    end
  end

  describe '属性' do
    it '商品名、数量、メモ、購入店舗、カート追加日時、並び順を持つこと' do
      item = ShoppingItem.new(
        shopping_list: shopping_list,
        name: 'テスト商品',
        quantity: '2個',
        memo: 'メモ',
        store_name: 'スーパー',
        picked_at: Time.current,
        position: 1
      )

      expect(item.name).to eq('テスト商品')
      expect(item.quantity).to eq('2個')
      expect(item.memo).to eq('メモ')
      expect(item.store_name).to eq('スーパー')
      expect(item.picked_at).to be_present
      expect(item.position).to eq(1)
    end

    it '数量、メモ、購入店舗、カート追加日時はnullでも有効であること' do
      item = shopping_list.items.build(
        name: 'テスト商品',
        quantity: nil,
        memo: nil,
        store_name: nil,
        picked_at: nil,
        position: 1
      )

      expect(item).to be_valid
    end
  end

  describe 'スコープ' do
    let!(:picked_item1) { shopping_list.items.create!(name: 'カート内商品1', position: 1, picked_at: Time.current) }
    let!(:picked_item2) { shopping_list.items.create!(name: 'カート内商品2', position: 2, picked_at: 1.hour.ago) }
    let!(:unpicked_item1) { shopping_list.items.create!(name: '未カート商品1', position: 3, picked_at: nil) }
    let!(:unpicked_item2) { shopping_list.items.create!(name: '未カート商品2', position: 4, picked_at: nil) }

    describe '.picked' do
      it 'カート内商品のみを取得すること' do
        expect(ShoppingItem.picked).to match_array([picked_item1, picked_item2])
      end
    end

    describe '.unpicked' do
      it '未カート商品のみを取得すること' do
        expect(ShoppingItem.unpicked).to match_array([unpicked_item1, unpicked_item2])
      end
    end

    describe '.for_store' do
      let!(:supermarket_item) { shopping_list.items.create!(name: 'スーパー商品', position: 5, store_name: 'スーパー') }
      let!(:drugstore_item) { shopping_list.items.create!(name: 'ドラッグストア商品', position: 6, store_name: 'ドラッグストア') }
      let!(:no_store_item) { shopping_list.items.create!(name: '店舗未設定商品', position: 7, store_name: nil) }

      it '指定した店舗の商品を取得すること' do
        expect(ShoppingItem.for_store('スーパー')).to include(supermarket_item)
      end

      it '店舗未設定の商品も含めること' do
        result = ShoppingItem.for_store('スーパー')
        expect(result).to include(supermarket_item, no_store_item)
        expect(result).not_to include(drugstore_item)
      end
    end
  end

  describe 'ヘルパーメソッド' do
    let(:item) { shopping_list.items.create!(name: 'テスト商品', position: 1) }

    describe '#picked?' do
      it 'picked_atがnilの場合、falseを返すこと' do
        item.picked_at = nil
        expect(item.picked?).to be false
      end

      it 'picked_atが設定されている場合、trueを返すこと' do
        item.picked_at = Time.current
        expect(item.picked?).to be true
      end
    end

    describe '#pick!' do
      it 'picked_atに現在時刻を設定すること' do
        freeze_time do
          item.pick!
          expect(item.picked_at).to be_within(1.second).of(Time.current)
        end
      end

      it 'データベースに保存されること' do
        item.pick!
        item.reload
        expect(item.picked_at).to be_present
      end
    end

    describe '#unpick!' do
      it 'picked_atをnilに設定すること' do
        item.update!(picked_at: Time.current)
        item.unpick!
        expect(item.picked_at).to be_nil
      end

      it 'データベースに保存されること' do
        item.update!(picked_at: Time.current)
        item.unpick!
        item.reload
        expect(item.picked_at).to be_nil
      end
    end
  end

  describe '並び順管理（positioning gem）' do
    describe 'position の自動設定' do
      it '新しい商品がリストの末尾に追加されること' do
        item1 = shopping_list.items.create!(name: '商品1')
        item2 = shopping_list.items.create!(name: '商品2')
        item3 = shopping_list.items.create!(name: '商品3')

        expect(item1.position).to eq(1)
        expect(item2.position).to eq(2)
        expect(item3.position).to eq(3)
      end

      it '削除後も残りの商品のpositionが整合性を保つこと' do
        item1 = shopping_list.items.create!(name: '商品1')
        item2 = shopping_list.items.create!(name: '商品2')
        item3 = shopping_list.items.create!(name: '商品3')

        item2.destroy

        expect(shopping_list.items.order(:position).pluck(:name)).to eq(['商品1', '商品3'])
      end
    end

    describe '相対位置指定による並び替え' do
      let!(:item1) { shopping_list.items.create!(name: '商品1') }
      let!(:item2) { shopping_list.items.create!(name: '商品2') }
      let!(:item3) { shopping_list.items.create!(name: '商品3') }
      let!(:item4) { shopping_list.items.create!(name: '商品4') }

      it '商品を別の商品の後ろに移動できること' do
        # 商品4を商品1の後ろに移動
        item4.update!(position: { after: item1.id })

        items = shopping_list.items.order(:position)
        expect(items.pluck(:name)).to eq(['商品1', '商品4', '商品2', '商品3'])
      end

      it '商品をリストの先頭に移動できること' do
        # 商品4を先頭に移動
        item4.update!(position: { after: nil })

        items = shopping_list.items.order(:position)
        expect(items.pluck(:name)).to eq(['商品4', '商品1', '商品2', '商品3'])
      end

      it '商品をリストの末尾に移動できること' do
        # 商品1を商品4（最後）の後ろに移動
        item1.update!(position: { after: item4.id })

        items = shopping_list.items.order(:position)
        expect(items.pluck(:name)).to eq(['商品2', '商品3', '商品4', '商品1'])
      end

      it '複数の商品を並び替えても整合性が保たれること' do
        # 商品3を先頭に
        item3.update!(position: { after: nil })
        # 商品1を商品4の後ろに
        item1.update!(position: { after: item4.id })

        items = shopping_list.items.order(:position)
        expect(items.pluck(:name)).to eq(['商品3', '商品2', '商品4', '商品1'])

        # positionが1から順番に連番になっていることを確認
        expect(items.pluck(:position)).to eq([1, 2, 3, 4])
      end
    end

    describe 'リストごとの独立性' do
      let(:another_list) { ShoppingList.create!(name: '別の買い物リスト') }

      it '異なるリストの商品は独立したpositionを持つこと' do
        item1 = shopping_list.items.create!(name: 'リスト1の商品1')
        item2 = another_list.items.create!(name: 'リスト2の商品1')
        item3 = shopping_list.items.create!(name: 'リスト1の商品2')

        expect(item1.position).to eq(1)
        expect(item2.position).to eq(1)
        expect(item3.position).to eq(2)
      end
    end
  end
end
