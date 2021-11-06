public struct WorkoutDBProvider {
    var text = "Your Workout Database provider"
    var serviceLocator = ServiceLocator(entitiesRepo: RealmEntityRepo())
}
