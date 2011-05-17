module TicketsHelper
  def state_for(comment)
    content_tag(:div, :class => "states") do
      if comment.state
        if comment.previous_state && comment.state != comment.previous_state
          "#{State.model_name.human}: #{render comment.previous_state} &rarr; #{render comment.state}".html_safe
        else
          "#{State.model_name.human}: #{render comment.state}".html_safe
        end
      end
    end
  end
end
