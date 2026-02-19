import ComposableArchitecture
import Inject
import SwiftUI

struct AboutView: View {
    @ObserveInjection var inject
    @Bindable var store: StoreOf<SettingsFeature>
    @State private var showingChangelog = false

    var body: some View {
        Form {
            Section {
                HStack {
                    Label("Version", systemImage: "info.circle")
                    Spacer()
                    Text(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unknown")
                        .foregroundStyle(.secondary)
                }
                HStack {
                    Label("Changelog", systemImage: "doc.text")
                    Spacer()
                    Button("Show Changelog") {
                        showingChangelog.toggle()
                    }
                    .buttonStyle(.bordered)
                    .sheet(isPresented: $showingChangelog) {
                        ChangelogView()
                    }
                }
                HStack {
                    Label("Source code", systemImage: "apple.terminal.on.rectangle")
                    Spacer()
                    Link("github.com/sasha-computer/oct", destination: URL(string: "https://github.com/sasha-computer/oct")!)
                }
                HStack {
                    Label("Based on Hex by Kit Langton", systemImage: "heart")
                    Spacer()
                    Link("github.com/kitlangton/Hex", destination: URL(string: "https://github.com/kitlangton/Hex")!)
                }
            }
        }
        .formStyle(.grouped)
        .enableInjection()
    }
}
