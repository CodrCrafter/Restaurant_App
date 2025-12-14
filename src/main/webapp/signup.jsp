<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up | Foodie Delight</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary: #FF6B35;
            --primary-dark: #E55A2B;
            --dark: #1A1A2E;
            --light: #F8F9FA;
            --error: #EF4444;
            --success: #10B981;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .signup-container {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            width: 100%;
            max-width: 450px;
            animation: slideUp 0.6s ease;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .signup-header {
            background: var(--primary);
            color: white;
            padding: 40px 30px;
            text-align: center;
        }

        .signup-header h1 {
            font-size: 32px;
            margin-bottom: 10px;
        }

        .signup-header p {
            opacity: 0.9;
            font-size: 16px;
        }

        .signup-form {
            padding: 40px 30px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: var(--dark);
        }

        .input-with-icon {
            position: relative;
        }

        .input-with-icon i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--primary);
        }

        .form-control {
            width: 100%;
            padding: 15px 15px 15px 45px;
            border: 2px solid #E5E7EB;
            border-radius: 10px;
            font-size: 16px;
            transition: all 0.3s;
        }

        .form-control:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(255, 107, 53, 0.1);
        }

        .terms-checkbox {
            display: flex;
            align-items: flex-start;
            gap: 10px;
            margin-bottom: 25px;
        }

        .terms-checkbox input[type="checkbox"] {
            margin-top: 4px;
            accent-color: var(--primary);
        }

        .terms-checkbox label {
            font-size: 14px;
            color: var(--dark);
        }

        .btn-signup {
            width: 100%;
            padding: 15px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
        }

        .btn-signup:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(255, 107, 53, 0.2);
        }

        .btn-signup:active {
            transform: translateY(0);
        }

        .error-message {
            background: #FEE2E2;
            color: var(--error);
            padding: 12px 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 14px;
            display: none;
        }

        .success-message {
            background: #D1FAE5;
            color: var(--success);
            padding: 12px 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            text-align: center;
            font-size: 14px;
            display: none;
        }

        .footer-links {
            text-align: center;
            margin-top: 25px;
            padding-top: 25px;
            border-top: 1px solid #E5E7EB;
        }

        .footer-links p {
            color: #6B7280;
            margin-bottom: 10px;
        }

        .footer-links a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
        }

        .footer-links a:hover {
            text-decoration: underline;
        }

        /* Password toggle */
        .password-toggle {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            background: none;
            border: none;
            color: #9CA3AF;
            cursor: pointer;
            font-size: 18px;
        }

        @media (max-width: 480px) {
            .signup-container {
                max-width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="signup-container">
        <div class="signup-header">
            <h1><i class="fas fa-utensils"></i> Join Foodie Delight</h1>
            <p>Create your account in just a few seconds</p>
        </div>
        
        <div class="signup-form">
            <%
                String error = request.getParameter("error");
                String message = request.getParameter("message");
                
                if ("UserExists".equals(error)) {
            %>
            <div class="error-message" id="errorMessage" style="display: block;">
                Username already exists. Please choose a different one.
            </div>
            <%
                }
                
                if ("Success".equals(message)) {
            %>
            <div class="success-message" id="successMessage" style="display: block;">
                Account created successfully! <a href="login.jsp">Click here to login</a>
            </div>
            <%
                }
            %>
            
            <form action="signup" method="post" id="signupForm">
                <div class="form-group">
                    <label for="username">Username</label>
                    <div class="input-with-icon">
                        <i class="fas fa-user"></i>
                        <input type="text" id="username" name="username" class="form-control" placeholder="Enter your username" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="password">Password</label>
                    <div class="input-with-icon">
                        <i class="fas fa-lock"></i>
                        <input type="password" id="password" name="password" class="form-control" placeholder="Enter password (any)" required>
                        <button type="button" class="password-toggle" onclick="togglePassword('password')">
                            <i class="fas fa-eye"></i>
                        </button>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="email">Email (Optional)</label>
                    <div class="input-with-icon">
                        <i class="fas fa-envelope"></i>
                        <input type="email" id="email" name="email" class="form-control" placeholder="email@example.com">
                    </div>
                </div>
                
                <div class="terms-checkbox">
                    <input type="checkbox" id="terms" name="terms" required>
                    <label for="terms">
                        I agree to the terms and conditions
                    </label>
                </div>
                
                <button type="submit" class="btn-signup">
                    <i class="fas fa-user-plus"></i> Create Account
                </button>
            </form>
            
            <div class="footer-links">
                <p>Already have an account? <a href="login.jsp">Login here</a></p>
            </div>
        </div>
    </div>

    <script>
        // Toggle password visibility
        function togglePassword(fieldId) {
            const field = document.getElementById(fieldId);
            const icon = field.nextElementSibling.querySelector('i');
            
            if (field.type === 'password') {
                field.type = 'text';
                icon.className = 'fas fa-eye-slash';
            } else {
                field.type = 'password';
                icon.className = 'fas fa-eye';
            }
        }
        
        // Simple form validation
        document.getElementById('signupForm').addEventListener('submit', function(e) {
            const username = document.getElementById('username').value.trim();
            const password = document.getElementById('password').value;
            const terms = document.getElementById('terms').checked;
            
            // Basic validation
            if (username.length < 2) {
                e.preventDefault();
                alert('Username must be at least 2 characters');
                return false;
            }
            
            if (password.length < 1) {
                e.preventDefault();
                alert('Password is required');
                return false;
            }
            
            if (!terms) {
                e.preventDefault();
                alert('Please agree to the terms and conditions');
                return false;
            }
            
            return true;
        });
        
        // Save form data to localStorage on input change
        document.querySelectorAll('#signupForm input, #signupForm textarea').forEach(function(input) {
            input.addEventListener('input', function() {
                // Save each field to localStorage
                localStorage.setItem('signup_' + this.name, this.value);
            });
            
            // Load saved data when page loads
            window.addEventListener('load', function() {
                const savedValue = localStorage.getItem('signup_' + input.name);
                if (savedValue) {
                    input.value = savedValue;
                }
            });
        });
        
        // Save checkbox state
        const termsCheckbox = document.getElementById('terms');
        termsCheckbox.addEventListener('change', function() {
            localStorage.setItem('signup_terms', this.checked);
        });
        
        // Load checkbox state
        window.addEventListener('load', function() {
            const savedTerms = localStorage.getItem('signup_terms');
            if (savedTerms === 'true') {
                termsCheckbox.checked = true;
            }
        });
        
        // Clear saved data when form is successfully submitted
        document.getElementById('signupForm').addEventListener('submit', function() {
            // Clear all saved form data
            Object.keys(localStorage).forEach(function(key) {
                if (key.startsWith('signup_')) {
                    localStorage.removeItem(key);
                }
            });
        });
    </script>
</body>
</html>
