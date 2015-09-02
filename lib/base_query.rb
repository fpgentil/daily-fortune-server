# Base Class to Query
# Usage:
#
#   Class ObjectQuery < BaseQuery
#     # Define the initialize method with your relation, as below 
#     def initialize params
#       super ::Model.all
#     end
#   end
#
# After definition you can call the query as below
# query = Query::Object.new params
# query.metadata
# => { :total_entries => 90, :total_pages => 3, :page => 1, :per_page => 30 }
class BaseQuery
  extend Forwardable
  DEFAULT_PER_PAGE = 30

  # Delegators to active record
  def_delegators :@relation, :empty?, :size, :count, :each, :map, :first, :last, :[]

  # Delegators to paginate
  def_delegators :@relation, :total_entries, :total_pages, :current_page

  attr_reader :relation, :metadata

  def initialize relation
    @relation = relation
    self
  end

  # Do the pagination on @relation object
  #
  # @param [Integer] params[:page] Number of current page. Default: 1
  # @param [Integer] params[:per_page] Number of resources by call. Default: 30
  def paginate params={}
    params[:per_page] ||= DEFAULT_PER_PAGE
    params[:page]     ||= 1
    @relation = @relation.paginate(page: params[:page], per_page: params[:per_page])
    @metadata = { total_entries: @relation.total_entries.to_i,
                  total_pages: @relation.total_pages.to_i,
                  page_entries: @relation.each.count, 
                  current_page: params[:page].to_i,
                  per_page: params[:per_page].to_i }
    self
  end
end
