// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// 追加したい野菜の名前を
  /// 入力してください
  internal static let addDialogTitle = L10n.tr("Localizable", "add_dialog_title", fallback: "追加したい野菜の名前を\n入力してください")
  /// 追加
  internal static let addText = L10n.tr("Localizable", "add_text", fallback: "追加")
  /// 全て
  internal static let allText = L10n.tr("Localizable", "all_text", fallback: "全て")
  /// キャンセル
  internal static let canselText = L10n.tr("Localizable", "cansel_text", fallback: "キャンセル")
  /// 花
  internal static let categoryFlower = L10n.tr("Localizable", "category_flower", fallback: "花")
  /// 葉
  internal static let categoryLeaf = L10n.tr("Localizable", "category_leaf", fallback: "葉")
  /// カテゴリーを選択してください
  internal static let categoryNone = L10n.tr("Localizable", "category_none", fallback: "カテゴリーを選択してください")
  /// 分類なし
  internal static let categoryOther = L10n.tr("Localizable", "category_other", fallback: "分類なし")
  /// yyyy-MM-dd HH:mm:ss
  internal static let dateFormat = L10n.tr("Localizable", "dateFormat", fallback: "yyyy-MM-dd HH:mm:ss")
  /// 選択した項目を削除
  internal static let deleteModeTitle = L10n.tr("Localizable", "delete_mode_title", fallback: "選択した項目を削除")
  /// 削除
  internal static let deleteText = L10n.tr("Localizable", "delete_text", fallback: "削除")
  /// 完了
  internal static let doneText = L10n.tr("Localizable", "done_text", fallback: "完了")
  /// 編集
  internal static let editText = L10n.tr("Localizable", "edit_text", fallback: "編集")
  /// 一覧画面
  internal static let homeNavigationTitle = L10n.tr("Localizable", "home_navigation_title", fallback: "一覧画面")
  /// ja_JP
  internal static let japanIdentifier = L10n.tr("Localizable", "japan_identifier", fallback: "ja_JP")
  /// .jpeg
  internal static let jpegExtension = L10n.tr("Localizable", "jpeg_extension", fallback: ".jpeg")
  /// 管理画面へ
  internal static let navigateManageScreenText = L10n.tr("Localizable", "navigate_manage_screen_text", fallback: "管理画面へ")
  /// 
  internal static let noneText = L10n.tr("Localizable", "none_text", fallback: "")
  /// ここに撮影した画像が表示されます
  internal static let pictureNoneText = L10n.tr("Localizable", "picture_none_text", fallback: "ここに撮影した画像が表示されます")
  /// 登録する
  internal static let registerDataButtonText = L10n.tr("Localizable", "register_data_button_text", fallback: "登録する")
  /// 正しい数値を入力してください
  internal static let registerDialogErrorText = L10n.tr("Localizable", "register_dialog_error_text", fallback: "正しい数値を入力してください")
  /// 撮影した写真の大きさを
  /// 入力してください
  internal static let registerDialogTitile = L10n.tr("Localizable", "register_dialog_titile", fallback: "撮影した写真の大きさを\n入力してください")
  /// 選択なし
  internal static let statusDefault = L10n.tr("Localizable", "status_default", fallback: "選択なし")
  /// 生育終了
  internal static let statusEnd = L10n.tr("Localizable", "status_end", fallback: "生育終了")
  /// お気に入り
  internal static let statusFavorite = L10n.tr("Localizable", "status_favorite", fallback: "お気に入り")
  /// 撮影する
  internal static let takePhotoButtonText = L10n.tr("Localizable", "take_photo_button_text", fallback: "撮影する")
  /// vegeItemList
  internal static let userDefaultVegeItemList = L10n.tr("Localizable", "user_default_vege_item_list", fallback: "vegeItemList")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
