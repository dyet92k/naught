require 'naught/null_class_builder/command'

module Naught
  class NullClassBuilder
    module Commands
      class Traceable < Naught::NullClassBuilder::Command
        def call
          defer do |subject|
            subject.module_eval do
              attr_reader :__file__, :__line__

              def initialize(options={})
                backtrace = options.fetch(:caller) { Kernel.caller(4) }
                @__file__, line, _ = backtrace[0].split(':')
                @__line__ = line.to_i
              end
            end
          end
        end
      end
    end
  end
end

