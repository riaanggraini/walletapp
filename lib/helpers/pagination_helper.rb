module PaginationHelper
  def paginate(collection, page_param, per_page_param)
    page = page_param || 1
    per_page = per_page_param || 10

    paginated_collection = collection.page(page).per(per_page)

    {
      collection: paginated_collection,
      pagination: {
        current_page: paginated_collection.current_page,
        next_page: paginated_collection.next_page,
        prev_page: paginated_collection.prev_page,
        total_pages: paginated_collection.total_pages,
        total_count: paginated_collection.total_count
      }
    }
  end
end
