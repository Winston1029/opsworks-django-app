application "packaginator" do
  path "/project/packaginator"
  owner "ubuntu"
  group "app"
  repository "https://github.com/coderanger/packaginator.git"
  revision "master"
  migrate true
  packages ["libpq-dev", "git-core", "mercurial"]

  django do 
    packages ["redis"]
    requirements "requirements/mkii.txt"
    settings_template "settings.py.erb"
    debug true
    collectstatic "build_static --noinput"
    database do
      database "melonpie"
      engine "postgresql_psycopg2"
      username "melonpie"
      password "Melonpie2014"
      host "melonpie.cgdkzz4oruxy.ap-southeast-1.rds.amazonaws.com"
      port "5432"
    end
    database_master_role "rds_superuser"
  end

  gunicorn do
    only_if { node['roles'].include? 'packaginator_application_server' }
    app_module :django
    port 8080
  end

  celery do
    only_if { node['roles'].include? 'packaginator_application_server' }
    config "celery_settings.py"
    django true
    celerybeat true
    celerycam true
    broker do
      transport "redis"
    end
  end

  nginx_load_balancer do
    only_if { node['roles'].include? 'packaginator_load_balancer' }
    application_port 8080
    static_files "/site_media" => "site_media"
  end

end
