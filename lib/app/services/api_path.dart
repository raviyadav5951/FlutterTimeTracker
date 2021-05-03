/// this class will hold all the paths that we need 
/// Bifurcation like we have all api urls mentioned in one file.

class APIPath {
  static String job(String uid, String jobId) => '/users/$uid/jobs/$jobId';
  
}
