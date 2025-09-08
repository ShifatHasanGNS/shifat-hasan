<%@ Page Title="Home" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="shifat_hasan.Pages.Home" ResponseEncoding="utf-8" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
  <title>Md. Shifat Hasan | Portfolio</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&family=Poppins:wght@400;600;700&display=swap" rel="stylesheet">

<style>    
    * {
      box-sizing: border-box;
    }
    
    :root {
      /* Dark Theme Slate Color Palette */
      --slate-50: #f8fafc;
      --slate-100: #f1f5f9;
      --slate-200: #e2e8f0;
      --slate-300: #cbd5e1;
      --slate-400: #94a3b8;
      --slate-500: #64748b;
      --slate-600: #475569;
      --slate-700: #334155;
      --slate-800: #1e293b;
      --slate-900: #0f172a;
      --slate-950: #020617;
      
      /* Accent Colors */
      --accent-primary: #3b82f6;
      --accent-secondary: #8b5cf6;
      --accent-success: #10b981;
      --accent-warning: #f59e0b;
      --accent-error: #ef4444;
      
      /* Gradients */
      --gradient-primary: linear-gradient(135deg, var(--accent-primary), var(--accent-secondary));
      --gradient-dark: linear-gradient(135deg, var(--slate-800), var(--slate-900));
      --gradient-card: linear-gradient(135deg, var(--slate-800), var(--slate-700));
      
      /* Shadows */
      --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
      --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
      --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
      --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
      --shadow-2xl: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
      
      /* Transitions */
      --transition-fast: 0.15s ease-in-out;
      --transition-normal: 0.3s ease-in-out;
      --transition-slow: 0.5s ease-in-out;
    }
    
    body {
      font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      line-height: 1.6;
      color: var(--slate-100);
      background: var(--gradient-dark);
      margin: 0;
      padding: 0;
      -webkit-font-smoothing: antialiased;
      -moz-osx-font-smoothing: grayscale;
    }
    
    /* Hero Section */
    .hero-section {
      min-height: 100vh;
      position: relative;
      overflow: hidden;
      display: flex;
      align-items: center;
      padding: 2rem 1rem;
    }
    
    .hero-section::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: url('data:image/svg+xml,<svg width="60" height="60" viewBox="0 0 60 60" xmlns="http://www.w3.org/2000/svg"><g fill="none" fill-rule="evenodd"><g fill="%233b82f6" fill-opacity="0.03"><circle cx="30" cy="30" r="2"/></g></svg>');
      pointer-events: none;
    }
    
    .hero-container {
      max-width: 1200px;
      margin: 0 auto;
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 4rem;
      align-items: center;
      position: relative;
      z-index: 1;
    }
    
    .hero-image {
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 2rem;
    }
    
    .profile-image {
      width: 300px;
      height: 300px;
      border-radius: 9999px;
      object-fit: cover;
      border: 4px solid var(--slate-800);
      box-shadow: var(--shadow-xl);
      transition: var(--transition-normal);
      background: var(--gradient-primary);
    }
    
    .profile-image:hover {
      transform: scale(1.05) rotate(2deg);
      box-shadow: var(--shadow-2xl);
    }
    
    .social-links {
      display: flex;
      gap: 1rem;
      justify-content: center;
    }
    
    .social-link {
      width: 48px;
      height: 48px;
      border-radius: 9999px;
      background: var(--slate-800);
      display: flex;
      align-items: center;
      justify-content: center;
      color: var(--slate-400);
      text-decoration: none;
      transition: var(--transition-fast);
      box-shadow: var(--shadow-md);
      border: 1px solid var(--slate-700);
    }
    
    .social-link:hover {
      background: var(--gradient-primary);
      color: white;
      transform: translateY(-2px);
      box-shadow: var(--shadow-lg);
    }
    
    .hero-content {
      display: flex;
      flex-direction: column;
      gap: 1.5rem;
    }
    
    .welcome-message {
      display: inline-block;
      background: var(--gradient-primary);
      background-clip: text;
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      font-weight: 600;
      font-size: 1.125rem;
      margin-bottom: 0.5rem;
    }
    
    .hero-title {
      font-family: 'Poppins', 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      font-size: clamp(2.5rem, 5vw, 4rem);
      font-weight: 700;
      line-height: 1.2;
      margin: 0;
      color: var(--slate-100);
    }
    
    .name-highlight {
      background: var(--gradient-primary);
      background-clip: text;
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      position: relative;
    }
    
    .typewriter-container {
      height: 60px;
      display: flex;
      align-items: center;
    }
    
    .typewriter {
      font-size: 1.5rem;
      font-weight: 600;
      color: var(--slate-400);
      font-family: 'Poppins', 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    }
    
    .cursor {
      display: inline-block;
      width: 3px;
      height: 1.5rem;
      background: var(--gradient-primary);
      margin-left: 2px;
      animation: blink 1s infinite;
    }
    
    @keyframes blink {
      0%, 50% { opacity: 1; }
      51%, 100% { opacity: 0; }
    }
    
    .hero-description {
      font-size: 1.125rem;
      color: var(--slate-400);
      line-height: 1.7;
      margin: 0;
      max-width: 600px;
    }
    
    .cta-button {
      display: inline-flex;
      align-items: center;
      justify-content: center;
      padding: 1rem 2rem;
      background: var(--gradient-primary);
      color: white;
      text-decoration: none;
      border-radius: 0.75rem;
      font-weight: 600;
      font-size: 1.125rem;
      box-shadow: var(--shadow-md);
      transition: var(--transition-normal);
      position: relative;
      overflow: hidden;
      width: fit-content;
    }
    
    .cta-button::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
      transition: left 0.5s ease-in-out;
    }
    
    .cta-button:hover::before {
      left: 100%;
    }
    
    .cta-button:hover {
        transform: translateY(-2px);
        box-shadow: var(--shadow-lg);
    }

    /* Animation classes */
    .fade-in {
        animation: fadeIn 0.6s ease-out;
    }

    .slide-in {
        animation: slideIn 0.5s ease-out;
    }

    .pulse-on-hover:hover {
        animation: pulse 0.3s ease-in-out;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    @keyframes slideIn {
        from { opacity: 0; transform: translateX(-20px); }
        to { opacity: 1; transform: translateX(0); }
    }

    @keyframes pulse {
        0%, 100% { transform: scale(1); }
        50% { transform: scale(1.05); }
    }
    
    /* About Section Styles */
    .about-section {
      padding: 4rem 1rem;
      position: relative;
      scroll-margin-top: 90px;
    }
    
    .about-container {
      max-width: 1200px;
      margin: 0 auto;
    }
    
    .about-content {
      display: grid;
      grid-template-columns: 1fr;
      gap: 3rem;
      margin-top: 3rem;
    }
    
    .about-card {
      background: rgba(30, 41, 59, 0.8);
      backdrop-filter: blur(20px);
      border-radius: 24px;
      padding: 2rem;
      box-shadow: 
        0 8px 32px rgba(0, 0, 0, 0.3),
        0 2px 8px rgba(0, 0, 0, 0.2),
        inset 0 1px 0 rgba(255, 255, 255, 0.1);
      border: 1px solid rgba(59, 130, 246, 0.2);
      transition: all 0.3s ease;
    }
    
    .about-card:hover {
      transform: translateY(-5px);
      box-shadow: 
        0 12px 40px rgba(0, 0, 0, 0.4),
        0 4px 12px rgba(59, 130, 246, 0.2);
      border-color: rgba(59, 130, 246, 0.3);
    }
    
    .about-card h3 {
      font-family: 'Poppins', sans-serif;
      font-size: 1.5rem;
      font-weight: 700;
      margin: 0 0 1.5rem 0;
      color: var(--slate-100);
      display: flex;
      align-items: center;
      gap: 0.75rem;
    }
    
    .about-card h3 .emoji {
      font-size: 1.75rem;
    }
    
    .about-card h4 {
      font-family: 'Poppins', sans-serif;
      font-size: 1.25rem;
      font-weight: 600;
      margin: 1.5rem 0 1rem 0;
      color: var(--accent-primary);
    }
    
    .about-card p, .about-card li {
      color: var(--slate-300);
      line-height: 1.7;
      margin-bottom: 1rem;
    }
    
    .about-card ul {
      margin: 0.5rem 0 1rem 1.5rem;
      padding: 0;
    }
    
    .about-card li {
      margin-bottom: 0.5rem;
    }
    
    .about-card strong {
      color: var(--slate-200);
      font-weight: 600;
    }
    
    .skills-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
      gap: 1.5rem;
      margin-top: 2rem;
    }
    
    .skill-category {
      background: rgba(51, 65, 85, 0.6);
      border-radius: 16px;
      padding: 1.5rem;
      border: 1px solid rgba(75, 85, 99, 0.3);
    }
    
    .skill-category h5 {
      font-weight: 600;
      color: var(--accent-secondary);
      margin: 0 0 1rem 0;
      font-size: 1rem;
    }
    
    .quote {
      text-align: center;
      font-style: italic;
      color: var(--slate-400);
      font-size: 1.125rem;
      margin: 3rem 0 0 0;
      padding: 2rem;
      border-top: 1px solid rgba(75, 85, 99, 0.3);
    }
    
    /* Projects Section */
    .highlight-projects {
      padding: 4rem 1rem;
      position: relative;
      scroll-margin-top: 90px;
    }
    
    .projects-container {
      max-width: 1200px;
      margin: 0 auto;
    }
    
    .section-title {
      font-family: 'Poppins', 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      font-size: clamp(2rem, 4vw, 3rem);
      font-weight: 700;
      text-align: center;
      margin: 0 0 1rem;
      color: var(--slate-100);
    }
    
    .text-gradient {
      background: var(--gradient-primary);
      background-clip: text;
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
    }
    
    .section-subtitle {
      text-align: center;
      color: var(--slate-400);
      font-size: 1.125rem;
      margin: 0 0 4rem;
      max-width: 600px;
      margin-left: auto;
      margin-right: auto;
    }
    
    /* Unified grid for project cards rendered into #project-cards */
    #project-cards {
      display: grid;
      grid-template-columns: repeat(2, minmax(0, 1fr)); /* max two per row on non-mobile */
      gap: 1.5rem;
      margin-top: 2.5rem;
      align-items: stretch;
    }
    
    .project-card {
      background: rgba(30, 41, 59, 0.8);
      backdrop-filter: blur(20px);
      border-radius: 24px;
      overflow: hidden;
      box-shadow: 
        0 8px 32px rgba(0, 0, 0, 0.3),
        0 2px 8px rgba(0, 0, 0, 0.2),
        inset 0 1px 0 rgba(255, 255, 255, 0.1);
      transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
      border: 1px solid rgba(59, 130, 246, 0.2);
      position: relative;
      cursor: pointer;
      display: flex;
      flex-direction: column;
    }
    
    .project-card::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: linear-gradient(135deg, 
        rgba(59, 130, 246, 0.1) 0%, 
        rgba(139, 92, 246, 0.1) 50%, 
        rgba(236, 72, 153, 0.1) 100%);
      opacity: 0;
      transition: opacity 0.4s ease;
      z-index: 1;
    }
    
    .project-card::after {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      height: 3px;
      background: linear-gradient(90deg, 
        var(--accent-primary) 0%, 
        var(--accent-secondary) 50%, 
        #ec4899 100%);
      transform: scaleX(0);
      transform-origin: left;
      transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
      z-index: 2;
    }
    
    .project-card:hover::before {
      opacity: 1;
    }
    
    .project-card:hover::after {
      transform: scaleX(1);
    }
    
    .project-card:hover {
      transform: translateY(-12px) scale(1.02);
      box-shadow: 
        0 20px 60px rgba(0, 0, 0, 0.4),
        0 8px 24px rgba(59, 130, 246, 0.2),
        inset 0 1px 0 rgba(255, 255, 255, 0.2);
      border-color: rgba(59, 130, 246, 0.4);
    }
    
    /* Image-first simple card used by FeatureProjectsRepeater */
    .project-card img {
      width: 100%;
      height: auto;
      aspect-ratio: 1.618 / 1; /* Golden ratio: width:height */
      object-fit: cover;
      display: block;
    }
    
    .project-card h3 {
      margin: 0.875rem 1rem 1.125rem;
      font-size: 1.1rem;
      line-height: 1.35;
      font-weight: 700;
      background: linear-gradient(135deg, var(--slate-100) 0%, var(--slate-300) 100%);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }
    
    .project-image {
      height: 220px;
      background: linear-gradient(135deg, 
        rgba(59, 130, 246, 0.9) 0%, 
        rgba(139, 92, 246, 0.9) 100%);
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-size: 1.25rem;
      font-weight: 600;
      position: relative;
      overflow: hidden;
      z-index: 3;
    }
    
    .project-image img {
      width: 100%;
      height: 220px;
      object-fit: cover;
      transition: transform 0.4s ease;
    }
    
    .project-card:hover .project-image img {
      transform: scale(1.05);
    }
    
    .project-image::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: linear-gradient(135deg, 
        rgba(0, 0, 0, 0.1) 0%, 
        rgba(0, 0, 0, 0.3) 100%);
      pointer-events: none;
      z-index: 1;
    }
    
    .project-content {
      padding: 2rem;
      display: flex;
      flex-direction: column;
      gap: 1.25rem;
      position: relative;
      z-index: 3;
    }
    
    .project-title {
      font-family: 'Poppins', 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
      font-size: 1.5rem;
      font-weight: 700;
      margin: 0;
      color: var(--slate-100);
      line-height: 1.3;
      background: linear-gradient(135deg, var(--slate-100) 0%, var(--slate-300) 100%);
      -webkit-background-clip: text;
      -webkit-text-fill-color: transparent;
      background-clip: text;
    }
    
    .project-description {
      color: var(--slate-400);
      line-height: 1.7;
      margin: 0;
      flex-grow: 1;
      font-size: 1rem;
    }
    
    .project-links {
      display: flex;
      gap: 1rem;
      margin-top: 1.5rem;
    }
    
    .project-link {
      padding: 0.75rem 1.5rem;
      border-radius: 12px;
      text-decoration: none;
      font-weight: 600;
      font-size: 0.9rem;
      transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
      border: 2px solid rgba(59, 130, 246, 0.3);
      color: var(--slate-300);
      background: rgba(30, 41, 59, 0.6);
      backdrop-filter: blur(10px);
      position: relative;
      overflow: hidden;
    }
    
    .project-link::before {
      content: '';
      position: absolute;
      top: 0;
      left: -100%;
      width: 100%;
      height: 100%;
      background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.1), transparent);
      transition: left 0.5s ease;
    }
    
    .project-link.demo {
      background: linear-gradient(135deg, var(--accent-primary) 0%, var(--accent-secondary) 100%);
      color: white;
      border-color: transparent;
      box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
    }
    
    .project-link:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
    }
    
    .project-link:hover::before {
      left: 100%;
    }
    
    .project-link.demo:hover {
      box-shadow: 0 8px 25px rgba(59, 130, 246, 0.4);
      transform: translateY(-2px) scale(1.05);
    }
    
    .project-link:not(.demo):hover {
      border-color: var(--accent-primary);
      color: var(--accent-primary);
      background: rgba(59, 130, 246, 0.1);
    }
    
    /* Responsive Design */
    @media (max-width: 968px) {
      .about-content {
        grid-template-columns: 1fr;
      }
      
      .skills-grid {
        grid-template-columns: 1fr;
      }
    }
    
    @media (max-width: 768px) {
      .hero-container {
        grid-template-columns: 1fr;
        text-align: center;
        gap: 2rem;
      }
      
      .hero-content {
        align-items: center;
        text-align: center;
      }
      
      .welcome-message {
        text-align: center;
      }
      
      .hero-title {
        text-align: center;
      }
      
      .typewriter-container {
        justify-content: center;
      }
      
      .hero-description {
        text-align: center;
        margin: 0 auto;
      }
      
      .cta-button {
        align-self: center;
      }
      
      .profile-image {
        width: 250px;
        height: 250px;
      }
      
      #project-cards {
        grid-template-columns: 1fr; /* two -> one on tablet */
        gap: 1rem;
        padding: 0 0.5rem;
      }
      
      .hero-section {
        padding: 1.5rem 1rem;
      }
      
      .highlight-projects, .about-section {
        padding: 2rem 1rem;
      }
      
      .project-card {
        border-radius: 20px;
      }
      
      .project-image,
      .project-card img {
        height: auto;
        aspect-ratio: 1.618 / 1;
      }
      
      .project-content {
        padding: 1.5rem;
      }
      
      .project-title {
        font-size: 1.25rem;
      }
      
      .project-links {
        flex-direction: column;
        gap: 0.75rem;
      }
      
      .project-link {
        text-align: center;
        padding: 0.875rem 1.5rem;
      }
      
      .about-card {
        padding: 1.5rem;
      }
      
      .about-card h3 {
        font-size: 1.25rem;
      }
      
      .skills-grid {
        grid-template-columns: 1fr;
        gap: 1rem;
      }
    }
    
    @media (max-width: 480px) {
      #project-cards {
        grid-template-columns: 1fr; /* one per row on mobile */
        gap: 0.875rem;
        padding: 0 0.25rem;
      }
      
      .project-card {
        border-radius: 16px;
      }
      
      .project-image,
      .project-card img {
        height: auto;
        aspect-ratio: 1.618 / 1;
      }
      
      .project-content {
        padding: 1.25rem;
        gap: 1rem;
      }
      
      .project-title {
        font-size: 1.125rem;
      }
      
      .project-description {
        font-size: 0.9rem;
      }
      
      .profile-image {
        width: 200px;
        height: 200px;
      }
      
      .social-links {
        gap: 0.5rem;
      }
      
      .social-link {
        width: 40px;
        height: 40px;
      }
      
      .hero-title {
        font-size: 2rem;
        text-align: center;
      }
      
      .typewriter {
        font-size: 1.25rem;
      }
      
      .typewriter-container {
        justify-content: center;
      }
      
      .welcome-message {
        text-align: center;
        font-size: 1rem;
      }
      
      .hero-description {
        font-size: 1rem;
        text-align: center;
      }
      
      .about-card {
        padding: 1.25rem;
      }
      
      .skill-category {
        padding: 1.25rem;
      }
    }
    
    /* Accessibility Improvements */
    @media (prefers-reduced-motion: reduce) {
      * {
        animation-duration: 0.01ms !important;
        animation-iteration-count: 1 !important;
        transition-duration: 0.01ms !important;
      }
      
      .cursor {
        animation: none;
        opacity: 1;
      }
    }
    
    /* Focus Styles */
    .cta-button:focus,
    .project-link:focus,
    .social-link:focus {
      outline: 2px solid var(--accent-primary);
      outline-offset: 2px;
    }
    
    /* Print Styles */
    @media print {
      .hero-section {
        min-height: auto;
        padding: 1.5rem;
      }
      
      .social-links {
        display: none;
      }
      
      .cta-button {
        display: none;
      }
      
      .project-card, .about-card {
        break-inside: avoid;
        box-shadow: none;
        border: 1px solid #e2e8f0;
      }
    }
    
    /* Modern Gradient Line */
    .section-separator {
        border: none;
        height: 2px;
        width: 200px;
        margin: 3rem auto;
        background: linear-gradient(90deg, transparent, #6366f1, transparent);
        border-radius: 2px;
    }
    
    /* Alternative Styles - Choose one that fits your design */
    
    /* Subtle Shadow Line */
    .section-separator.shadow {
        border: none;
        height: 1px;
        width: 150px;
        margin: 3rem auto;
        background: #e5e7eb;
        box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
    }
    
    /* Animated Glow */
    .section-separator.glow {
        border: none;
        height: 2px;
        width: 180px;
        margin: 3rem auto;
        background: linear-gradient(90deg, transparent, #8b5cf6, transparent);
        border-radius: 2px;
        animation: pulse 2s ease-in-out infinite alternate;
    }
    
    @keyframes pulse {
        from {
            opacity: 0.6;
            box-shadow: 0 0 10px rgba(139, 92, 246, 0.3);
        }
        to {
            opacity: 1;
            box-shadow: 0 0 20px rgba(139, 92, 246, 0.6);
        }
    }
    
    /* Dotted Style */
    .section-separator.dotted {
        border: none;
        height: 4px;
        width: 120px;
        margin: 3rem auto;
        background-image: radial-gradient(circle, #6b7280 2px, transparent 2px);
        background-size: 12px 4px;
        background-repeat: repeat-x;
    }
    
    /* Double Line */
    .section-separator.double {
        border: none;
        height: 3px;
        width: 160px;
        margin: 3rem auto;
        background: linear-gradient(to right, 
            transparent, 
            #374151 25%, 
            #374151 30%, 
            transparent 35%,
            transparent 65%,
            #374151 70%, 
            #374151 75%, 
            transparent
        );
    }
    
    /* Minimalist with Fade */
    .section-separator.fade {
        border: none;
        height: 1px;
        width: 240px;
        margin: 3rem auto;
        background: linear-gradient(90deg, 
            transparent, 
            rgba(107, 114, 128, 0.3) 20%, 
            rgba(107, 114, 128, 1) 50%, 
            rgba(107, 114, 128, 0.3) 80%, 
            transparent
        );
    }
    
    /* Dark Mode Variant */
    @media (prefers-color-scheme: dark) {
        .section-separator {
            background: linear-gradient(90deg, transparent, #8b5cf6, transparent);
        }
        
        .section-separator.shadow {
            background: #374151;
            box-shadow: 0 1px 3px rgba(255, 255, 255, 0.1);
        }
        
        .section-separator.fade {
            background: linear-gradient(90deg, 
                transparent, 
                rgba(156, 163, 175, 0.3) 20%, 
                rgba(156, 163, 175, 1) 50%, 
                rgba(156, 163, 175, 0.3) 80%, 
                transparent
            );
        }
    }
</style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <section class="hero-section fade-in">
        <div class="hero-container">
            <div class="hero-image slide-in">
                <img src='<%= ResolveUrl("~/Static/shifat-hasan-new.jpeg") %>' alt="Shifat Hasan" class="profile-image" 
                     onerror="this.style.display='none'; this.parentElement.innerHTML='<div style=&quot;width:300px;height:300px;border-radius:50%;background:linear-gradient(45deg,#667eea,#764ba2);display:flex;align-items:center;justify-content:center;color:white;font-size:2rem;font-weight:bold;&quot;>SH</div>';" />
                <div class="social-links">
                    <a href="https://github.com/ShifatHasanGNS" class="social-link pulse-on-hover" title="GitHub" target="_blank" rel="noopener noreferrer">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M12 0c-6.626 0-12 5.373-12 12 0 5.302 3.438 9.8 8.207 11.387.599.111.793-.261.793-.577v-2.234c-3.338.726-4.033-1.416-4.033-1.416-.546-1.387-1.333-1.756-1.333-1.756-1.089-.745.083-.729.083-.729 1.205.084 1.839 1.237 1.839 1.237 1.07 1.834 2.807 1.304 3.492.997.107-.775.418-1.305.762-1.604-2.665-.305-5.467-1.334-5.467-5.931 0-1.311.469-2.381 1.236-3.221-.124-.303-.535-1.524.117-3.176 0 0 1.008-.322 3.301 1.23.957-.266 1.983-.399 3.003-.404 1.02.005 2.047.138 3.006.404 2.291-1.552 3.297-1.23 3.297-1.23.653 1.653.242 2.874.118 3.176.77.84 1.235 1.911 1.235 3.221 0 4.609-2.807 5.624-5.479 5.921.43.372.823 1.102.823 2.222v3.293c0 .319.192.694.801.576 4.765-1.589 8.199-6.086 8.199-11.386 0-6.627-5.373-12-12-12z"/>
                        </svg>
                    </a>
                  <a href="https://www.facebook.com/ShifatHasanGNS" class="social-link pulse-on-hover" title="Facebook" target="_blank" rel="noopener noreferrer">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                      <path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/>
                    </svg>
                  </a>
                  <a href="https://www.instagram.com/ShifatHasanGNS" class="social-link pulse-on-hover" title="Instagram" target="_blank" rel="noopener noreferrer">
                    <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                      <path d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z"/>
                    </svg>
                  </a>
                    <a href="mailto:shifathasan.pro@gmail.com" class="social-link pulse-on-hover" title="Email">
                        <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor">
                            <path d="M24 5.457v13.909c0 .904-.732 1.636-1.636 1.636h-3.819V11.73L12 16.64l-6.545-4.91v9.273H1.636A1.636 1.636 0 0 1 0 19.366V5.457c0-.904.732-1.636 1.636-1.636h1.034l9.33 7.87 9.33-7.87h1.034c.904 0 1.636.732 1.636 1.636z"/>
                        </svg>
                    </a>
                </div>
            </div>
            <div class="hero-content">
                <div class="welcome-message fade-in">👋 Welcome to my Portfolio</div>
                <h1 class="hero-title fade-in">Hi, I'm <span class="name-highlight">Shifat</span></h1>
                <div class="typewriter-container fade-in">
                    <div class="typewriter" id="typewriter">
                        <span id="typewriter-text"></span>
                        <span class="cursor"></span>
                    </div>
                </div>
                <p class="hero-description fade-in">
                    Computer Science Engineering student at KUET with a passion for crafting innovative software solutions. 
                    I blend academic knowledge with hands-on development experience to build applications that make a difference. 
                    Currently exploring the intersections of web development, algorithms, and emerging technologies.
                </p>
                <a href="#about-section" class="cta-button pulse-on-hover">Learn More About Me</a>
            </div>
        </div>
    </section>
  
    <hr class="section-separator"/>
  
    <section class="about-section fade-in" id="about-section">
        <div class="about-container">
            <h2 class="section-title slide-in"><span class="text-gradient">About Me</span></h2>
            <p class="section-subtitle fade-in">Passionate Computer Science student building tomorrow's solutions today</p>
            
            <div class="about-content">
                <div class="about-card fade-in">
                    <h3><span class="emoji">🎓</span>Education & Background</h3>
                    <p>Currently pursuing <strong>Computer Science & Engineering</strong> at <strong>Khulna University of Engineering & Technology (KUET)</strong>, one of Bangladesh's premier engineering institutions. My academic journey combines theoretical computer science foundations with practical programming expertise.</p>
                </div>

                <div class="about-card fade-in">
                    <h3><span class="emoji">💻</span>Technical Skills</h3>
                    
                    <div class="skills-grid">
                        <div class="skill-category">
                            <h5>Programming Languages:</h5>
                            <p><strong>Primary:</strong> JavaScript, Python, Java<br/>
                            <strong>Learning:</strong> C++, TypeScript, Go</p>
                        </div>
                        
                        <div class="skill-category">
                            <h5>Web Development:</h5>
                            <p><strong>Frontend:</strong> React.js, HTML5, CSS3, Tailwind CSS<br/>
                            <strong>Backend:</strong> Node.js, Express.js, REST APIs<br/>
                            <strong>Database:</strong> MongoDB, MySQL, PostgreSQL</p>
                        </div>
                        
                        <div class="skill-category">
                            <h5>Tools & Technologies:</h5>
                            <p><strong>Version Control:</strong> Git, GitHub<br/>
                            <strong>Development:</strong> VS Code, Postman, Chrome DevTools<br/>
                            <strong>Deployment:</strong> Vercel, Netlify, Heroku</p>
                        </div>
                    </div>
                </div>

                <div class="about-card fade-in">
                    <h3><span class="emoji">🚀</span>Project Experience</h3>
                    <p><strong>Web Applications:</strong> Built full-stack applications focusing on user experience and performance optimization</p>
                    <p><strong>Algorithm Implementation:</strong> Developed solutions for competitive programming problems and data structure challenges</p>
                    <p><strong>Academic Projects:</strong> Created software systems as part of coursework, emphasizing clean code and documentation</p>
                </div>

                <div class="about-card fade-in">
                    <h3><span class="emoji">🎯</span>Interests & Preferences</h3>
                    
                    <h4>Favorite Project Types:</h4>
                    <ul>
                        <li>Interactive web applications</li>
                        <li>Educational technology tools</li>
                        <li>Data visualization projects</li>
                        <li>Problem-solving utilities</li>
                    </ul>
                    
                    <h4>Development Philosophy:</h4>
                    <ul>
                        <li>Clean, readable code</li>
                        <li>User-centered design</li>
                        <li>Continuous learning</li>
                        <li>Open source contribution</li>
                    </ul>
                    
                    <h4>Currently Exploring:</h4>
                    <ul>
                        <li>Machine Learning integration in web apps</li>
                        <li>Mobile app development</li>
                        <li>Cloud computing platforms</li>
                        <li>DevOps practices</li>
                    </ul>
                </div>

                <div class="about-card fade-in">
                    <h3><span class="emoji">🌟</span>Goals & Vision</h3>
                    <p>Aspiring to become a versatile software engineer who can bridge the gap between complex technical solutions and real-world user needs. I'm particularly interested in projects that combine technology with education, sustainability, or community impact.</p>
                    
                    <h4>Looking forward to:</h4>
                    <ul>
                        <li>Contributing to open source projects</li>
                        <li>Internship opportunities in tech companies</li>
                        <li>Collaborative projects with fellow developers</li>
                        <li>Building solutions that positively impact society</li>
                    </ul>
                </div>
            </div>

            <div class="quote fade-in">
                <em>"Code is poetry written in logic, and every program tells a story of problem-solving and creativity."</em>
            </div>
        </div>
    </section>
  
    <hr class="section-separator"/>

    <section class="highlight-projects fade-in" id="projects">
        <div class="projects-container">
            <h2 class="section-title slide-in">Featured <span class="text-gradient">Projects</span></h2>
            <p class="section-subtitle fade-in">Here are some of my recent works that showcase my skills and creativity</p>
          
            <div id="project-cards">
              <asp:Repeater ID="FeatureProjectsRepeater" runat="server">
                <ItemTemplate>
                  <div class="project-card pulse-on-hover" data-project-id="<%# Eval("id") %>">
                    <img src='<%# Eval("url_cover_image") %>' alt='<%# Eval("title") %>' onerror="handleImageError(this)" />
                    <h3><%# Eval("title") %></h3>
                  </div>
                </ItemTemplate>
              </asp:Repeater>
            </div>
        </div>
    </section>
    
    <!-- Hidden field to store project data for JavaScript -->
    <asp:HiddenField ID="FeatureProjectsJsonData" runat="server" />

    <script type="text/javascript">
        // Updated typewriter texts based on About.md suggestions
        var texts = [
            "CSE Student at KUET",
            "Software Developer", 
            "Tech Enthusiast",
            "Digital Creator",
            "Problem Solver",
            "Innovation Builder"
        ];
        var textIndex = 0;
        var charIndex = 0;
        var isDeleting = false;
        var typeSpeed = 100;

        function typeWriter() {
            var currentText = texts[textIndex];
            var typewriterElement = document.getElementById('typewriter-text');

            if (!typewriterElement) {
                return; // Element not found, exit function
            }

            if (isDeleting) {
                typewriterElement.textContent = currentText.substring(0, charIndex - 1);
                charIndex--;
                typeSpeed = 70;
            } else {
                typewriterElement.textContent = currentText.substring(0, charIndex + 1);
                charIndex++;
                typeSpeed = 70;
            }

            if (!isDeleting && charIndex === currentText.length) {
                typeSpeed = 3000; // Pause at end
                isDeleting = true;
            } else if (isDeleting && charIndex === 0) {
                isDeleting = false;
                textIndex = (textIndex + 1) % texts.length;
            }

            setTimeout(typeWriter, typeSpeed);
        }

        // Initialize page functionality
        function initializePage() {
            // Start typewriter effect
            setTimeout(typeWriter, 1000);

            // Setup smooth scrolling for CTA button
            var ctaButton = document.querySelector('.cta-button');
            if (ctaButton) {
                ctaButton.addEventListener('click', function(e) {
                    e.preventDefault();
                    var aboutSection = document.getElementById('about-section');
                    if (aboutSection) {
                        aboutSection.scrollIntoView({
                            behavior: 'smooth'
                        });
                    }
                });
            }
        }

        // Cross-browser DOM ready function
        function domReady(fn) {
            if (document.readyState === 'complete' || document.readyState === 'interactive') {
                setTimeout(fn, 1);
            } else {
                document.addEventListener('DOMContentLoaded', fn);
            }
        }

        // Initialize when DOM is ready
        domReady(initializePage);

        // Fallback initialization for older browsers
        if (window.addEventListener) {
            window.addEventListener('load', initializePage, false);
        } else if (window.attachEvent) {
            window.attachEvent('onload', initializePage);
        }
        
        // Load feature projects data from hidden field

        var projectsData = [];

        function initializeProjectsData() {
            var jsonData = document.getElementById('<%= FeatureProjectsJsonData.ClientID %>').value;
            if (jsonData) {
                projectsData = JSON.parse(jsonData);
            }
        }

        function openProjectModal(projectId) {
            var project = projectsData.find(p => p.id === projectId);
            if (!project) return;

            var modalContent = document.getElementById('modalContent');
            var html = '<div class="project-detail">';
            
            // Cover image
            if (project.url_cover_image) {
                html += '<img src="' + project.url_cover_image + '" alt="' + project.title + '" class="modal-cover-image" />';
            }
            
            // Title
            html += '<h2>' + project.title + '</h2>';
            
            // Type
            html += '<p class="project-type"><strong>Type:</strong> ' + project.type + '</p>';
            
            // Description
            if (project.description) {
                html += '<div class="project-description"><strong>Description:</strong><br/>' + project.description.replace(/\n/g, '<br/>') + '</div>';
            }
            
            // Links section
            html += '<div class="project-links"><strong>Links:</strong><br/>';
            
            if (project.url_github) {
                html += '<a href="' + project.url_github + '" target="_blank" rel="noopener">GitHub Repository</a><br/>';
            }
            
            if (project.url_drive) {
                html += '<a href="' + project.url_drive + '" target="_blank" rel="noopener">Google Drive</a><br/>';
            }
            
            if (project.url_youtube) {
                html += '<a href="' + project.url_youtube + '" target="_blank" rel="noopener">YouTube Video</a><br/>';
            }
            
            if (project.url_other) {
                html += '<a href="' + project.url_other + '" target="_blank" rel="noopener">Other Link</a><br/>';
            }
            
            html += '</div>';
            html += '</div>';
            
            modalContent.innerHTML = html;
            document.getElementById('projectModal').style.display = 'block';
        }

        function closeProjectModal() {
            document.getElementById('projectModal').style.display = 'none';
        }

        // Close modal when clicking outside of it
        window.onclick = function(event) {
            var modal = document.getElementById('projectModal');
            if (event.target === modal) {
                closeProjectModal();
            }
        }

        // Close modal with Escape key
        document.addEventListener('keydown', function(event) {
            if (event.key === 'Escape') {
                closeProjectModal();
            }
        });

        // Handle image loading errors
        function handleImageError(img) {
            img.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzAwIiBoZWlnaHQ9IjIwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KICA8cmVjdCB3aWR0aD0iMTAwJSIgaGVpZ2h0PSIxMDAlIiBmaWxsPSIjZjBmMGYwIi8+CiAgPHRleHQgeD0iNTAlIiB5PSI1MCUiIGZvbnQtZmFtaWx5PSJBcmlhbCIgZm9udC1zaXplPSIxNCIgZmlsbD0iIzk5OSIgdGV4dC1hbmNob3I9Im1pZGRsZSIgZHk9Ii4zZW0iPk5vIEltYWdlPC90ZXh0Pgo8L3N2Zz4=';
        }

        // Add event delegation for project cards
        document.addEventListener('click', function(event) {
            const projectCard = event.target.closest('.project-card');
            if (projectCard && projectCard.dataset.projectId) {
                openProjectModal(projectCard.dataset.projectId);
            }
        });

        // Initialize data when page loads
        window.addEventListener('load', function() {
            initializeProjectsData();
        });
    </script>
</asp:Content>
