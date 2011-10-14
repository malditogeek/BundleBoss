module BundleBoss
  module Watchdog
    class << self
      def load(settings = {})
        @settings = settings['settings']
        @bundler  = settings['bundler']
        @projects = settings['projects'].map {|path| File.expand_path(path) }
      end

      def project_index
        @index ||= @projects.inject({}) do |accum, path|
          accum[path.hash] = BundleBoss::Project.new(path, @bundler, @settings)
          accum
        end
      end

      def info(name, msg)
        p [:info, name, msg]
        if @settings['notifications']
          GrowlNotify.normal(:title => name,
                             :description => msg,
                             :icon => File.expand_path('./images/pending.png'))
        end
      end

      def success(name)
        p [:success, name]
        if @settings['notifications']
          GrowlNotify.very_low(:title => name,
                               :description => 'All systems go!',
                               :icon => File.expand_path('./images/success.png'))
        end
      end

      def error(name, msg)
        p [:error, msg]
        if @settings['notifications']
          GrowlNotify.sticky!(:title => name,
                              :description => msg,
                              :icon => File.expand_path('./images/failed.png'))
        end
      end

      def run!
        watchdog = FSEvent.new
        watchdog.watch project_index.values.map(&:path) do |paths|
          paths.each do |path|
            hash = File.expand_path(path).hash
            project = project_index[hash]
            next unless project
            project.bundle if project.gemfile_changed?
          end
        end
        info('BundleBoss', 'Bundling like a boss.')
        watchdog.run
      end
    end
  end
end
