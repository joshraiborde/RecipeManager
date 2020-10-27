module ApplicationHelper
    def show_stars(count)
        content_tag :span, style: 'color: blue;' do
            count.round.times do 
                content_tag(:i, class: %[fas fa-star]) { }
            end
        end
    end
end
