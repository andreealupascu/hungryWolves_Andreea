protocol Displayable {
    var idLabelText: String { get }
    var nameLabelText: (label: String, value: String) { get }
    var imageURLLabelText: (label: String, value: String) { get }
}

protocol DisplayableCategories {
    var idCategoryText: String { get }
    var nameCategoryLabelText: (label: String, value: String) { get }
}

protocol DisplayableDetails {
    var idMealLabelText: String { get }
    var nameLabelText: (label: String, value: String) { get }
    var imageURLLabelText: (label: String, value: String) { get }
    var youtubeURLLabelText: (label: String, value: String) { get }
    var instructionsLabelText: (label: String, value: String) { get }
    var tagsLabelText: (label: String, value: String?) { get }
    var ingredient1LabelText: (label: String, value: String) { get }
    var ingredient2LabelText: (label: String, value: String) { get }
    var ingredient3LabelText: (label: String, value: String) { get }
    var measure1LabelText: (label: String, value: String) { get }
    var measure2LabelText: (label: String, value: String) { get }
    var measure3LabelText: (label: String, value: String) { get }

}
