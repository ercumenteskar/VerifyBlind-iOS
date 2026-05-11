import SwiftUI

struct ContentView: View {
    @State private var didSendTestEvent = false

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "person.text.rectangle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 96, height: 96)
                .foregroundStyle(.tint)

            Text("VerifyBlind")
                .font(.largeTitle.bold())

            Text("iOS — Aşama 0 boş iskelet")
                .font(.subheadline)
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 8) {
                row("Bundle ID", Bundle.main.bundleIdentifier ?? "?")
                row("Version", "\(Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "?") (\(Bundle.main.infoDictionary?["CFBundleVersion"] ?? "?"))")
                row("API", Config.apiBaseURL.absoluteString)
                row("AppAttest env", Config.appAttestEnvironment.rawValue)
                row("Sentry", Config.sentryDSN.isEmpty ? "kapalı" : "açık")
            }
            .font(.footnote.monospaced())
            .padding()
            .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 12))
            .padding(.horizontal)

            Button {
                Log.info("Manuel test event — pipeline doğrulaması", category: .flow)
                didSendTestEvent = true
            } label: {
                Label(didSendTestEvent ? "Gönderildi" : "Sentry'e test event gönder", systemImage: "paperplane.fill")
            }
            .buttonStyle(.borderedProminent)
            .disabled(didSendTestEvent)

            Spacer()
        }
        .padding()
        .onAppear {
            Log.info("ContentView göründü", category: .flow)
        }
    }

    private func row(_ label: String, _ value: String) -> some View {
        HStack(alignment: .top) {
            Text(label)
                .foregroundStyle(.secondary)
                .frame(width: 110, alignment: .leading)
            Text(value)
                .lineLimit(2)
                .truncationMode(.middle)
        }
    }
}

#Preview {
    ContentView()
}
