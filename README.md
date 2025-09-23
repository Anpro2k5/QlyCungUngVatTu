<<<<<<< HEAD
Project: BtlJSP (reorganized MVC layout)

What changed
- Views (JSPs) moved into webapp/views/{mathang, nhanvien, phanxuong}
- index.jsp moved into webapp/index.jsp
- Build artifact moved to /dist (BtlJSP.war)
- Runtime and JVM crash logs moved to /logs
- Duplicate/misnamed WEB_INF merged into WEB-INF
- .gitignore added to ignore build outputs and logs

How the project is laid out now
- webapp/
  - index.jsp
  - views/
    - mathang/
    - nhanvien/
    - phanxuong/
- WEB-INF/
  - web.xml
  - classes/ (compiled Java classes)
  - lib/ (JAR dependencies)
- QlyCungUngVatTu/ (maven project source & pom)
- dist/ (contains BtlJSP.war)
- logs/ (runtime and JVM logs)

Build and deploy
- Build with Maven from QlyCungUngVatTu (if needed):
  - mvn -f QlyCungUngVatTu/pom.xml clean package
- Deploy: copy dist/BtlJSP.war into Tomcat webapps folder or use your IDE's deploy mechanism.

Notes and next steps
- If you want, I can:
  - Update JSP paths and links if they reference old locations.
  - Move source JSPs into the maven webapp structure (src/main/webapp) and integrate with the pom.
  - Clean up compiled classes (rebuild instead of committing .class files).

Contact
- Let me know if you want the JSPs moved back or the README adjusted (Vietnamese or English).
=======
# QlyCungUngVatTu
JSP
>>>>>>> 4d6d0a85915b2cffa634f5c7294b27eb70ffad9f
