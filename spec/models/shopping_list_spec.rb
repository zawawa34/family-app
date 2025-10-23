require 'rails_helper'

RSpec.describe ShoppingList, type: :model do
  describe '関連' do
    it '複数の商品(items)を持つこと' do
      shopping_list = ShoppingList.create!(name: '買い物リスト')
      expect(shopping_list).to respond_to(:items)
    end

    it '削除時に関連する商品も削除されること' do
      shopping_list = ShoppingList.create!(name: '買い物リスト')
      shopping_list.items.create!(name: '商品1', position: 1)
      shopping_list.items.create!(name: '商品2', position: 2)

      expect { shopping_list.destroy }.to change { ShoppingItem.count }.by(-2)
    end

    it '所有者(owner)を持つことができること' do
      expect(ShoppingList.new).to respond_to(:owner)
    end

    it '所有者がnullでも有効であること' do
      shopping_list = ShoppingList.new(name: '買い物リスト', owner: nil)
      expect(shopping_list).to be_valid
    end
  end

  describe 'バリデーション' do
    it 'nameが必須であること' do
      shopping_list = ShoppingList.new(name: nil)
      expect(shopping_list).not_to be_valid
      expect(shopping_list.errors[:name]).to be_present
    end

    it 'nameがあれば有効であること' do
      shopping_list = ShoppingList.new(name: '買い物リスト')
      expect(shopping_list).to be_valid
    end
  end
end
