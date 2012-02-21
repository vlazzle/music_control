#!/usr/local/bin/macruby

framework "ScriptingBridge"

system_events = SBApplication.applicationWithBundleIdentifier 'com.apple.systemevents'
running_apps = system_events.processes.map(&:name)

if running_apps.include? 'Spotify'
  spotify = SBApplication.applicationWithBundleIdentifier 'com.spotify.client'

  if spotify.currentTrack.id
    spotify.play
    exit
  end
end

if running_apps.include? 'Google Chrome'
  chrome = SBApplication.applicationWithBundleIdentifier 'com.google.chrome'

  pandora_tab = nil
  chrome.windows.each do |window|
    window.tabs.each do |tab|
      if tab.URL =~ /pandora.com/
        pandora_tab = tab
      end
    end
  end

  play_js = <<-EOJS
  Pandora.pauseMusic(false)
  EOJS

  if pandora_tab
    pandora_tab.executeJavascript(play_js)
    exit
  end
end
