class AddAuthorToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :author_user_id, :integer
  end
end
