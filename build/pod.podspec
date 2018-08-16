Pod::Spec.new do |spec|
  spec.name         = 'Gtst'
  spec.version      = '{{.Version}}'
  spec.license      = { :type => 'GNU Lesser General Public License, Version 3.0' }
  spec.homepage     = 'https://github.com/justchain/go-justchain'
  spec.authors      = { {{range .Contributors}}
		'{{.Name}}' => '{{.Email}}',{{end}}
	}
  spec.summary      = 'iOS justchain Client'
  spec.source       = { :git => 'https://github.com/justchain/go-justchain.git', :commit => '{{.Commit}}' }

	spec.platform = :ios
  spec.ios.deployment_target  = '9.0'
	spec.ios.vendored_frameworks = 'Frameworks/Gtst.framework'

	spec.prepare_command = <<-CMD
    curl https://gtststore.blob.core.windows.net/builds/{{.Archive}}.tar.gz | tar -xvz
    mkdir Frameworks
    mv {{.Archive}}/Gtst.framework Frameworks
    rm -rf {{.Archive}}
  CMD
end
