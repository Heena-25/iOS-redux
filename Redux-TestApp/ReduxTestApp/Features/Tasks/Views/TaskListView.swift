import SwiftUI

struct TaskListView: View {
    @EnvironmentObject var store: Store
    @State private var showAddTask = false

    var filteredTasks: [Task] {
        switch store.state.selectedFilter {
        case .all:       return store.state.tasks
        case .active:    return store.state.tasks.filter { !$0.isCompleted }
        case .completed: return store.state.tasks.filter { $0.isCompleted }
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {

                FilterPickerView()
                    .padding(.vertical, 10)
                    .padding(.horizontal)

                Divider()

                Group {
                    if store.state.isLoading {
                        loadingView
                    } else if let error = store.state.errorMessage {
                        errorView(error)
                    } else if filteredTasks.isEmpty {
                        emptyView
                    } else {
                        taskList
                    }
                }
            }
            .navigationTitle("My Tasks")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddTask = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
            .sheet(isPresented: $showAddTask) {
                AddTaskView()
            }
            .onAppear {
                if store.state.tasks.isEmpty {
                    store.dispatch(.fetchTasksStarted)
                }
            }
        }
    }

    // MARK: - Subviews

    private var loadingView: some View {
        VStack(spacing: 12) {
            Spacer()
            ProgressView()
                .scaleEffect(1.3)
            Text("Loading tasks...")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
        }
    }

    private func errorView(_ message: String) -> some View {
        VStack(spacing: 16) {
            Spacer()
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 44))
                .foregroundColor(.orange)
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Button("Try Again") {
                store.dispatch(.fetchTasksStarted)
            }
            .buttonStyle(.borderedProminent)
            Spacer()
        }
    }

    private var emptyView: some View {
        VStack(spacing: 12) {
            Spacer()
            Image(systemName: "checklist")
                .font(.system(size: 44))
                .foregroundColor(.secondary.opacity(0.5))
            Text("No tasks here")
                .font(.headline)
                .foregroundColor(.secondary)
            Text("Tap + to add a new task")
                .font(.subheadline)
                .foregroundColor(.secondary.opacity(0.7))
            Spacer()
        }
    }

    private var taskList: some View {
        List {
            ForEach(filteredTasks) { task in
                TaskRow(task: task)
            }
            .onDelete { indexSet in
                indexSet.forEach { index in
                    store.dispatch(.deleteTask(id: filteredTasks[index].id))
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    TaskListView()
        .environmentObject(Store(
            middlewares: [
                loggingMiddleware(),
                apiMiddleware(taskService: TaskService())
            ]
        ))
}
