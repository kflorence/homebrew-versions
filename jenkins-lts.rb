require 'formula'

class JenkinsLts < Formula
  homepage 'http://jenkins-ci.org/#stable'
  url "http://mirrors.jenkins-ci.org/war-stable/1.554.3/jenkins.war"
  sha1 "173edb931212f2813c6ef5d2d9e3ca2c6770b35b"
  conflicts_with 'jenkins',
    :because => 'both use the same data directory: $HOME/.jenkins'

  def install
    libexec.install "jenkins.war"
  end

  plist_options :manual => "java -jar #{HOMEBREW_PREFIX}/opt/jenkins-lts/libexec/jenkins.war"

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>#{plist_name}</string>
        <key>ProgramArguments</key>
        <array>
          <string>/usr/bin/java</string>
          <string>-Dmail.smtp.starttls.enable=true</string>
          <string>-jar</string>
          <string>#{opt_prefix}/libexec/jenkins.war</string>
          <string>--httpListenAddress=127.0.0.1</string>
          <string>--httpPort=8080</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
      </dict>
    </plist>
    EOS
  end

  def caveats; <<-EOS.undent
    Note: When using launchctl the port will be 8080.
    EOS
  end
end
