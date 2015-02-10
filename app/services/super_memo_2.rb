class SuperMemo2
  def initialize(card)
    @card = card
  end

  def review(score)
    @card.score = score

    if score > 2
      update_ef(score)
      update_repetition_interval
      update_review_date
    else
      @card.repetition_number = 0
    end
  end

  private

  def update_ef(score)
    new_ef = @card.ef + (0.1 - (5 - score) * (0.08 + (5 - score) * 0.02))
    @card.ef = new_ef < 1.3 ? 1.3 : new_ef
  end

  def update_repetition_interval
    @card.repetition_number += 1

    case @card.repetition_number
    when 1
      @card.repetition_interval = 1
    when 2
      @card.repetition_interval = 6
    else
      if @card.repetition_number > 2
        @card.repetition_interval *= @card.ef
      end
    end
  end

  def update_review_date
    @card.review_date = Time.current + @card.repetition_interval.days
  end
end
