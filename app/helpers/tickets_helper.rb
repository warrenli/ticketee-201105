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

  def toggle_watching_button
    text = if @ticket.watchers.include?(current_user)
      t("tickets.unsubscribe_btn")
    else
      t("tickets.subscribe_btn")
    end
    button_to(text, watch_project_ticket_path(@ticket.project, @ticket))
  end
end
