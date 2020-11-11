module ApplicationHelper
    def show_stars(count)
        content_tag :span, style: 'color: blue;' do
            out = ActiveSupport::SafeBuffer.new
            count.round.times do 
                out << content_tag(:i, '', class: %[fas fa-star])
            end
            out
        end
    end
end
