module BooksHelper
  def icon(library)
    if library
       image_tag(library.image, class: "iconic mr-3")
    end 
  end
end
