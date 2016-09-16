class Medium < ActiveRecord::Base
  belongs_to :user

  #has_attached_file :foto, styles: { medium: "300x>", thumb: "100x>" }, default_url: "/images/:style/missing.png"
  has_attached_file :foto, styles: { medium: "300x>", thumb: "100x>" }, default_url: "/images/missing.png"  #percorso default in public
  validates_attachment_content_type :foto, content_type: /\Aimage\/.*\Z/

  def foto_media_url
    foto.url(:medium)
    #self.foto.url(:medium)
  end

end
