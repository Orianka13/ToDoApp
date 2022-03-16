//
//  APIClientTests.swift
//  ToDoAppTests
//
//  Created by Олеся Егорова on 11.03.2022.
//

import XCTest
@testable import ToDoApp

class APIClientTests: XCTestCase {
    
    var sut: APIClient!
    var mockURLSession: MockURLSession!
    
    override func setUpWithError() throws {
        super.setUp()
        mockURLSession = MockURLSession(data: nil, urlResponse: nil, responseError: nil)
        sut = APIClient()
        sut.urlSession = mockURLSession
    }

    override func tearDownWithError() throws {
     
    }
    
    func userLogin() {
        let completionHandler = {(token: String?, error: Error?) in }
        sut.login(withName: "name", password: "%qwerty", completionHandler: completionHandler)
        
    }

//проверим что при логине пользователя при обращении к серверу используется правильный хост
    func testLoginUsesCorrectHost() {
        userLogin()
        XCTAssertEqual(mockURLSession.urlComponents?.host, "todoapp.com")
    }
    //проверим что при логине используется правильный путь
    func testLoginUsesCorrectPath() {
        userLogin()
        XCTAssertEqual(mockURLSession.urlComponents?.path, "/login")
    }
    
    //проверим что передаем правильные параметры
    func testLoginUsesExpectedQueryParameters() {
        userLogin()
        
        guard let queryItems = mockURLSession.urlComponents?.queryItems else {
            XCTFail()
            return
        }
        let urlQueryItmeName = URLQueryItem(name: "name", value: "name")
        let urlQueryItemPassword = URLQueryItem(name: "password", value: "%qwerty")
        
        XCTAssertTrue(queryItems.contains(urlQueryItmeName))
        XCTAssertTrue(queryItems.contains(urlQueryItemPassword))
    }
    
    //проверим что при успешной авторизации генерируется токен
    //token -> Data -> completionHandler -> DataTask -> urlSession
    func testSuccessfullLoginCreatesToken() {
        let jsonDataStub = "{\"token\": \"tokenString\"}".data(using: .utf8) //объект который возвращается с сервера
        self.mockURLSession = MockURLSession(data: jsonDataStub, urlResponse: nil, responseError: nil)
        self.sut.urlSession = self.mockURLSession
        let tokenExpectation = expectation(description: "Token expectation")
        var caughtToken: String?
        self.sut.login(withName: "login", password: "password") { token, _ in
            caughtToken = token
            tokenExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(caughtToken, "tokenString")
        }
    }
    
    //проверим что выводится ошибка если пришел неверный формат json
    func testLoginInvalidJSONReturnsError() {
        self.mockURLSession = MockURLSession(data: Data(), urlResponse: nil, responseError: nil)
        self.sut.urlSession = self.mockURLSession
        let errorExpectation = expectation(description: "Error expectation")
        
        var caughtError: Error?
        self.sut.login(withName: "login", password: "password") { _, error in
            caughtError = error
            errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(caughtError)
        }
    }
    
    func testLoginWhenDataIsNilReturnsError() {
        self.mockURLSession = MockURLSession(data: nil, urlResponse: nil, responseError: nil)
        self.sut.urlSession = self.mockURLSession
        let errorExpectation = expectation(description: "Error expectation")
        
        var caughtError: Error?
        self.sut.login(withName: "login", password: "password") { _, error in
            caughtError = error
            errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(caughtError)
        }
    }
    
    func testLoginWhenResponseErrorReturnsError() {
        let jsonDataStub = "{\"token\": \"tokenString\"}".data(using: .utf8)
        let error = NSError(domain: "Server error", code: 404, userInfo: nil)
        mockURLSession = MockURLSession(data: jsonDataStub, urlResponse: nil, responseError: error)
        sut.urlSession = mockURLSession
        let errorExpectation = expectation(description: "Error expectation")
        
        var caughtError: Error?
        sut.login(withName: "login", password: "password") { _, error in
            caughtError = error
            errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(caughtError)
        }
    }

}

extension APIClientTests {
    class MockURLSession: URLSessionProtocol {
        var url: URL?
        private let mockDataTask: MockURLSessionDataTask
        
        var urlComponents: URLComponents? {
            guard let url = self.url else {
                return nil
            }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?){
            self.mockDataTask = MockURLSessionDataTask(data: data,
                                                       urlResponse: urlResponse,
                                                       responseError: responseError)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            self.url = url
            //return URLSession.shared.dataTask(with: url)
            self.mockDataTask.completionHandler = completionHandler
            return self.mockDataTask
        }
    }
    
    class MockURLSessionDataTask: URLSessionDataTask {
        private let data: Data?
        private let urlResponse: URLResponse?
        private let responseError: Error?
        
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
        var completionHandler: CompletionHandler?
        
        init(data: Data?, urlResponse: URLResponse?, responseError: Error?) {
            self.data = data
            self.urlResponse = urlResponse
            self.responseError = responseError
        }
        
        override func resume() {
            DispatchQueue.main.async {
                self.completionHandler?(
                    self.data,
                    self.urlResponse,
                    self.responseError
                )
            }
        }
    }
}
