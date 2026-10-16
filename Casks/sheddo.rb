cask "sheddo" do
  version "1.0.1"
  sha256 "0447536832782c7e0efe4a3d5c20083ae7ac455f23c1b68d0116ef126f949ed1"

  url "https://releases.sheddo.app/releases/Sheddo-#{version}.dmg"
  name "Sheddo"
  desc "Native terminal with project workspaces and workflow orchestration"
  homepage "https://sheddo.app/"

  livecheck do
    url "https://releases.sheddo.app/appcast.xml"
    strategy :sparkle do |item|
      item.short_version
    end
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "Sheddo.app"

  uninstall quit: "app.sheddo"

  # Includes workspace.db, SQLite sidecars, migration backups and recovery copies.
  # Never follow stored project paths or remove project files or shell history.
  # Preserve Keychain items (service: app.sheddo.secrets) for explicit user removal.
  zap trash: [
    "~/Library/Application Support/Sheddo",
    "~/Library/Caches/app.sheddo",
    "~/Library/HTTPStorages/app.sheddo",
    "~/Library/HTTPStorages/app.sheddo.binarycookies",
    "~/Library/Preferences/app.sheddo.plist",
    "~/Library/Saved Application State/app.sheddo.savedState",
  ]

  caveats <<~EOS
    Uninstalling with --zap removes Sheddo settings, saved workspaces, tasks,
    project registrations and database backups. Project files and shell history
    are preserved. Keychain secrets are preserved; remove items with the service
    app.sheddo.secrets manually in Keychain Access if needed.
  EOS
end
