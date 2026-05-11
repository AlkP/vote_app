module AnswersHelper
  def vote_bg_class(vote)
    case vote
    when 'yes' then 'bg-success bg-opacity-25'
    when 'no' then 'bg-danger bg-opacity-25'
    when 'neutral' then 'bg-secondary bg-opacity-25'
    else ''
    end
  end

  def vote_options(selected_vote = nil)
    options_for_select(
      [
        ['', ''],
        ['✓ За', 'yes'],
        ['✗ Против', 'no'],
        ['⚫ Возд.', 'neutral']
      ], selected: selected_vote
    )
  end
end
