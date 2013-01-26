module Facebook
  module HackerCup2013
    module Say
      def self.with_status(status, message, colorscheme = nil)
        # Create a color scheme, naming color patterns with symbol names.
        ft = HighLine::ColorScheme.new do |cs|
          cs[:headline]        = [ :bold, :yellow, :on_black ]
          cs[:horizontal_line] = [ :bold, :white, :on_blue]
          cs[:regular]         = [ ]
          cs[:information]     = [ :bold, :cyan ]
          cs[:success]         = [ :green ]
          cs[:failed]          = [ :bold, :yellow ]
          cs[:aborted]         = [ :orange ]
          cs[:error]           = [ :bold, :red ]
          cs[:committed]       = [ :bold, :blue ]
        end

        # Assign that color scheme to HighLine...
        HighLine.color_scheme = ft

        # default color scheme
        colorscheme ||= :regular

        status += " " * (15 - status.length)
        say("<%= color('#{status}', '#{colorscheme}') %> #{message}")

      end

      def self.info(message)
        # message += "\n" + "=" * message.length
        self.with_status "Information", message, :information
      end

      def self.success(message)
        self.with_status "Success", message, :success
      end

      def self.failed(message)
        self.with_status "Failed", message, :failed
      end

      def self.aborted(message)
        self.with_status "Aborted", message, :aborted
      end
    end
  end
end
