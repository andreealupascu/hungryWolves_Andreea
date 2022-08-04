protocol Displayable {
    var idLabelText: String { get }
    var nameLabelText: (label: String, value: String) { get }
    var imageURLLabelText: (label: String, value: String) { get }
}

protocol DisplaybleCategories {
    var idCategoryText: String { get }
    var nameCategoryLabelText: (label: String, value: String) { get }
}
