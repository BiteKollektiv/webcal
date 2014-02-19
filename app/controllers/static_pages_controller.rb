class StaticPagesController < ApplicationController
    def index
    @calendar=Calendar.new 
  end
end
