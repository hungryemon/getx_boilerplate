import '/helper/constants/value_constants.dart';

class PagingController<T> {
  List<T> listItems = [];
  int page = ValueConstants.defaultPageNumber;
  bool isInfiniteLoading = false;
  bool endOfList = false;
  int totalCount = 0;

  initRefresh() {
    listItems = [];
    page = ValueConstants.defaultPageNumber;
    isInfiniteLoading = false;
    endOfList = false;
  }

  bool canLoadNextPage() {
    return !isInfiniteLoading && !endOfList;
  }

  appendPage(List<T> items, {int totalCount = 0}) {
    this.totalCount = totalCount;
    if (_isLastPage(items.length, totalCount)) {
      appendLastPage(items);
    } else {
      listItems.addAll(items);
      page++;
    }
  }

  appendLastPage(List<T> items) {
    listItems.addAll(items);
    endOfList = true;
  }

  bool _isLastPage(int newListItemCount, int totalCount) {
    return (listItems.length + newListItemCount) >= totalCount;
  }
}
