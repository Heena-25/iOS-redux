import SwiftUI

struct TaskRow: View {
    @EnvironmentObject var store: Store
    let task: Task

    var body: some View {
        HStack(spacing: 14) {
            Button {
                store.dispatch(.toggleTask(id: task.id))
            } label: {
                Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
                    .foregroundColor(task.isCompleted ? .green : .gray.opacity(0.5))
                    .animation(.easeInOut(duration: 0.15), value: task.isCompleted)
            }
            .buttonStyle(.plain)

            Text(task.title)
                .font(.body)
                .strikethrough(task.isCompleted, color: .secondary)
                .foregroundColor(task.isCompleted ? .secondary : .primary)
                .animation(.easeInOut(duration: 0.15), value: task.isCompleted)

            Spacer()
        }
        .padding(.vertical, 6)
        .contentShape(Rectangle())
    }
}

#Preview {
    List {
        TaskRow(task: Task(title: "Buy groceries"))
        TaskRow(task: Task(title: "Read Swift docs", isCompleted: true))
    }
    .environmentObject(Store())
}
