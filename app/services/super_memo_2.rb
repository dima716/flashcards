class SuperMemo2
  def initialize(options)
    @score = options[:score]
    @repetition_number = options[:repetition_number]
    @repetition_interval = options[:repetition_interval]
    @ef = options[:ef]
  end

  def review
    if @score > 2
      update_ef(@score)
      update_repetition_interval
      { ef: @ef, repetition_number: @repetition_number, repetition_interval: @repetition_interval, score: @score }
    else
      @repetition_number = 0
      { repetition_number: @repetition_number, score: @score }
    end
  end

  private

  def update_ef(score)
    # count easy factor using formula from http://www.supermemo.com/english/ol/sm2.htm
    new_ef = @ef + (0.1 - (5 - score) * (0.08 + (5 - score) * 0.02))
    @ef = [new_ef, 1.3].max
  end

  def update_repetition_interval
    @repetition_number += 1

    case @repetition_number
    when 1
      @repetition_interval = 1
    when 2
      @repetition_interval = 6
    else
      if @repetition_number > 2
        @repetition_interval *= @ef
      end
    end
  end
end
