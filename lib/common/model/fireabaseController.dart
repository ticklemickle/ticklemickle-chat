import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ticklemickle_m/common/utils/const.dart';
import 'package:ticklemickle_m/screens/chatbot/questions/chatbotQuestions.dart';
import 'package:ticklemickle_m/screens/chatbot/results/answerList/common_answerList.dart';

Future<void> insertAllCategoriesToFirestore() async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Category 리스트 가져오기
    List<String> categoryList = [
      CategoryConst.questionsFinancialHistory,
      CategoryConst.questionsLoans,
      CategoryConst.questionsTaxes,
      CategoryConst.questionsStableInvestor,
      CategoryConst.questionsCrypto,
      CategoryConst.questionsRealEstateResidential,
      CategoryConst.questionsRealEstateCommercial,
      CategoryConst.questionsUSAStockInvestment,
      CategoryConst.questionsKoreaStockInvestment,
      CategoryConst.questionsLookalike,
      CategoryConst.questionsBasicStatus,
    ];

    for (String category in categoryList) {
      await firestore
          .collection('chatbot_questions')
          .doc(category) // 각 카테고리 이름을 문서 ID로 사용
          .set({
        'question': getQuestionsList(category), // 같은 데이터를 삽입
      });

      print('✅ $category 데이터 삽입 완료');
    }

    print('🚀 모든 카테고리 데이터 삽입 완료');
  } catch (e) {
    print('❌ Firestore 데이터 삽입 실패: $e');
  }
}

Future<List<Map<String, dynamic>>> getQuestionsListFromFirebase(
    String category) async {
  DocumentSnapshot docSnapshot = await FirebaseFirestore.instance
      .collection('chatbot_questions')
      .doc(category)
      .get();
  if (docSnapshot.exists) {
    Map<String, dynamic>? data = docSnapshot.data() as Map<String, dynamic>?;
    if (data != null && data.containsKey('question')) {
      return List<Map<String, dynamic>>.from(data['question']);
    }
  }
  return [];
}

Future<void> insertStockInvestorProfiles() async {
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    String collectionName = "stock_investor_profiles";

    for (var stock in commonStockList) {
      await firestore.collection(collectionName).doc(stock.sub).set({
        "image": stock.image,
        "sub": stock.sub,
        "title": stock.title,
        "match": stock.match,
        "description": stock.description,
      });

      print('✅ ${stock.title} 데이터 삽입 완료');
    }

    print('🚀 모든 투자 유형 데이터 삽입 완료');
  } catch (e) {
    print('❌ Firestore 데이터 삽입 실패: $e');
  }
}

Future<List<Map<String, dynamic>>> getStockResultFromFirebase(
    String sub) async {
  try {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('stock_investor_profiles')
        .where('sub', isEqualTo: sub)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    }
  } catch (e) {
    print('❌ Firestore 데이터 조회 실패: $e');
  }

  return [];
}

/* firebase초기데이터적재 */
void setInitDataFromFirebase() {
  /* 질문 목록 insert */
  // insertAllCategoriesToFirestore();

  /* stock result insert */
  // insertStockInvestorProfiles();
}
