public struct WorkoutDBProvider {
    public var text = "Your Workout Database provider"
    public let serviceLocator = ServiceLocator(entitiesRepo: RealmEntityRepo())
    public init() {
        
    }
}
