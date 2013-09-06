class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.belongs_to :user #make sure belongs to author_id
      t.string :title
      t.string :secret_key
      t.timestamps
    end
  end
end
