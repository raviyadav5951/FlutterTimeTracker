/// this class will hold all the paths that we need
/// Bifurcation like we have all api urls mentioned in one file.

class APIPath {
  static String job(String uid, String jobId) => 'users/$uid/jobs/$jobId';
  static String jobs(String uid) => 'users/$uid/jobs';
  static String entry(String uid,String entryId) => 'users/$uid/entries/$entryId';
  static String entries(String uid) => 'users/$uid/entries';


}
