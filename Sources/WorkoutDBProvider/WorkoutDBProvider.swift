public struct WorkoutDBProvider {
    public var text = "Your Workout Database provider"
    public let serviceLocator: EntitiesRepo
    public init() {
        self.serviceLocator = ServiceLocator(entitiesRepo: RealmEntityRepo()) as! any EntitiesRepo
    }
}
