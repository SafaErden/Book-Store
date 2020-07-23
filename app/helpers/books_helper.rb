module BooksHelper
  def icon(library)
    image_tag(library.image, class: 'iconic mr-3') if library
  end
end
