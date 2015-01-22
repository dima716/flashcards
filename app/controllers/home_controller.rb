class HomeController < ApplicationController
  def index
    @card = Card.for_review.first
    render "all_reviewed" unless @card
  end
end
