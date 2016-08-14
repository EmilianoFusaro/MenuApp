class AddAttachmentFotoToMedia < ActiveRecord::Migration
  def self.up
    change_table :media do |t|
      t.attachment :foto
    end
  end

  def self.down
    remove_attachment :media, :foto
  end
end
