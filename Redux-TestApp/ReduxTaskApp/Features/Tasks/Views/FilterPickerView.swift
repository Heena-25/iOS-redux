import SwiftUI

struct FilterPickerView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        Picker(
            "Filter",
            selection: Binding(
                get: { store.state.selectedFilter },
                set: { store.dispatch(.setFilter($0)) }
            )
        ) {
            ForEach(TaskFilter.allCases, id: \.self) { filter in
                Text(filter.rawValue).tag(filter)
            }
        }
        .pickerStyle(.segmented)
    }
}

#Preview {
    FilterPickerView()
        .padding()
        .environmentObject(Store())
}
