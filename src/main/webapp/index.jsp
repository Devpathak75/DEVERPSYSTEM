<!DOCTYPE html>
<html>
<head>
    <title>College ERP</title>

    <style>
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', sans-serif;
            background: #f4f6f9;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* ===== TOP GAP ===== */
        .top-gap {
            height: 28px;
            background: #f4f6f9;
        }

        /* ===== HEADER ===== */
        .header {
            background: #1a237e;
            color: white;
            padding: 18px 30px;
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .header img {
            height: 60px;
        }

        .header-title {
            font-size: 28px;
            font-weight: bold;
            letter-spacing: 1px;
            text-align: center;
            flex: 1;
        }

        /* ===== MAIN AREA ===== */
        .main {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* ===== CENTER BOX ===== */
        .box {
            width: 440px;
            background: white;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 12px 30px rgba(0,0,0,0.2);
            text-align: center;
            transition: 0.3s;
        }

        .box:hover {
            transform: translateY(-6px);
            box-shadow: 0 18px 40px rgba(0,0,0,0.3);
        }

        /* ===== BUTTON COMMON ===== */
        .btn {
            width: 100%;
            padding: 15px;
            margin: 16px 0;
            border: none;
            border-radius: 8px;
            font-size: 17px;
            cursor: pointer;
            transition: 0.3s;
            color: white;
        }

        /* ===== ADMIN BUTTON (PROFESSIONAL BLUE) ===== */
        .admin-btn {
            background: #1565c0;
        }

        .admin-btn:hover {
            background: #0d47a1;
        }

  /* ===== faculty BUTTON (PROFESSIONAL BLUE) ===== */
        .faculty-btn {
            background: #7955d0;
        }

        .faculty-btn:hover {
            background: #0d47a1;
        }


        /* ===== STUDENT BUTTON (PROFESSIONAL TEAL) ===== */
        .student-btn {
            background: #99695c;
        }

        .student-btn:hover {
            background: #004d40;
        }

        /* ===== FOOTER ===== */
        .footer {
            background: #0b0b0b;
            color: #e0e0e0;
            text-align: center;
            padding: 22px;
            font-size: 16px;
            letter-spacing: 0.5px;
        }
    </style>
</head>

<body>

    <!-- SMALL TOP GAP -->
    <div class="top-gap"></div>

    <!-- HEADER WITH IMAGES -->
    <div class="header">
        <!-- LEFT IMAGE -->
        <img src="images/university.png" alt="University Logo">

        <!-- CENTER TITLE -->
        <div class="header-title">
            Devs Institute of Technology and Engineering
        </div>

        <!-- RIGHT IMAGE -->
        <img src="images/college.png" alt="College Logo">
    </div>

    <!-- MAIN CONTENT -->
    <div class="main">
        <div class="box">
            <h2>Welcome to College ERP System</h2>
            <h3>Select Login Type</h3>

            <a href="login.jsp?type=admin">
                <button class="btn admin-btn">Admin Login</button>
            </a>

       <a href="login.jsp?type=faculty">
                <button class="btn faculty-btn">faculty Login</button>
            </a>
            
            <a href="login.jsp?type=student">
                <button class="btn student-btn">Student Login</button>
            </a>
         
        </div>
    </div>

    <!-- FOOTER -->
    <div class="footer">
        Developed by Dev Deepak Pathak
    </div>

</body>
</html>
