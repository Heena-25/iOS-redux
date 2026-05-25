import SwiftUI

struct AddTaskView: View {
    @EnvironmentObject var store: Store
    @Environment(\.dismiss) private var dismiss
    @State private var taskTitle = ""
    @FocusState private var isFocused: Bool

    var isValid: Bool {
        !taskTitle.trimmingCharacters(in: .whitespaces).isEmpty
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Task title")
                        .font(.subheadline)
                        .foregroundColor(.secondary)

                    TextField("e.g. Review pull request", text: $taskTitle)
                        .textFieldStyle(.roundedBorder)
                        .font(.body)
                        .focused($isFocused)
                        .submitLabel(.done)
                        .onSubmit { submit() }
                }
                .padding(.horizontal)
                .padding(.top, 24)

                Spacer()
            }
            .navigationTitle("New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") { submit() }
                        .fontWeight(.semibold)
                        .disabled(!isValid)
                }
            }
            .onAppear { isFocused = true }
        }
    }

    private func submit() {
        guard isValid else { return }
        store.dispatch(.addTask(title: taskTitle))
        dismiss()
    }
}

#Preview {
    AddTaskView()
        .environmentObject(Store())
}
