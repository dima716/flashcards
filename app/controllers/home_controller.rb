class HomeController < ApplicationController
  def index
    @card = Card.for_review.first
  end
end
