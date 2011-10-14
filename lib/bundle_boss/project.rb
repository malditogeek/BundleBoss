require 'digest/sha1'

module BundleBoss
  class Project
    attr_reader :path
  
    def initialize(path, bundler_options = {}, settings = {})
      @bundler_options = bundler_options
      @settings = settings
      @path = File.expand_path(path)
      @hash = @path.hash
      @sha1 = sha1
    end
  
    def sha1
      Digest::SHA1.hexdigest File.read(@path + '/Gemfile')
    end
  
    def bundle_update
      update_cmd = []
      update_cmd << "cd #{@path};"
      update_cmd << "#{bundle_path} update"
      run update_cmd
    end
  
    def run(cmd)
      stdout = nil
      ::Bundler.with_clean_env do
        ENV['RBENV_DIR'] = "#{@path}/"
        stdout = `#{cmd.join(' ')}`
      end
      stdout
    end

    def bundle_install
      install_cmd = []
      install_cmd << "#{bundle_path} install"
      install_cmd << "--gemfile #{@path}/Gemfile"
      install_cmd << "--quiet"
      @bundler_options.each do |key,value|
        install_cmd << "--#{key}" if value
        install_cmd << value if value.is_a? String
      end
      run install_cmd
    end

    def bundle_path
      "#{ENV['HOME']}/.rbenv/shims/bundle"
    end

    def gemfile_changed?
      @sha1 != sha1
    end

    def bundle
      BundleBoss::Watchdog.info name, 'Hardcore Bundle Action'

      stdout = bundle_install
      if stdout =~ /bundle update/
        if @settings['update']
          BundleBoss::Watchdog.info name, 'Updating...'
          bundle_update
          stdout = bundle_install
        end
      end

      if stdout.empty?
        BundleBoss::Watchdog.success(name)
      else
        BundleBoss::Watchdog.error(name, "#{stdout.gsub(/\e\[\w{1,2}m/,'')}")
      end

      @sha1 = sha1
    end
  
    def name
      @path.split('/').last
    end
  end
end
