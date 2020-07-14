class CreateAuths < ActiveRecord::Migration[5.2]
  def change
    create_table :auths do |t|

      t.timestamps
    end
  end
end
