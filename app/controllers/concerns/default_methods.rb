module DefaultMethods
  extend ActiveSupport::Concern

  def default_sort_by(sort, order)
    params.reverse_merge!({ :sort => sort, :order => order, :page => 1, :per_page => 100 })
  end
end