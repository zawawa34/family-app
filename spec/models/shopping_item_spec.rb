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
end
