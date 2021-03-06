# encoding: utf-8
module Yell #:nodoc:
  module Helpers #:nodoc:
    module Adapters #:nodoc:

      # Define an adapter to be used for logging.
      #
      # @example Standard adapter
      #   adapter :file
      #
      # @example Standard adapter with filename
      #   adapter :file, 'development.log'
      #
      #   # Alternative notation for filename in options
      #   adapter :file, :filename => 'developent.log'
      #
      # @example Standard adapter with filename and additional options
      #   adapter :file, 'development.log', :level => :warn
      #
      # @example Set the adapter directly from an adapter instance
      #   adapter( Yell::Adapter::File.new )
      #
      # @param [Symbol] type The type of the adapter, may be `:file` or `:datefile` (default `:file`)
      # @return [Yell::Adapter] The instance
      # @raise [Yell::NoSuchAdapter] Will be thrown when the adapter is not defined
      def adapter( type = :file, *args, &block )
        options = [@options, *args].inject( Hash.new ) do |h, c|
          h.merge( [String, Pathname].include?(c.class) ? {:filename => c} : c  )
        end

        @adapters << Yell::Adapters.new(type, options, &block)
      end

      # @private
      def adapters
        @adapters
      end


      private

      def reset!
        @adapters = []

        super
      end

    end
  end
end

