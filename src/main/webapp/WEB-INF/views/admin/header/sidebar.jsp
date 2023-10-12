<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
  <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-dark sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="noticeboard">
                <div class="sidebar-brand-text mx-3">Joonggomon</div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">



            <!-- Nav Item - Dashboard -->
            <li class="nav-item active">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
                       <i class="fa-solid fa-chalkboard"></i>
                    <span>게시판 관리</span>
                    <span class=”caret“></span></a>
                    <div id="collapseTwo" class="collapse"   data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">게시판 목록</h6>
                        <a class="collapse-item" href="/admin/normalBoard">자유게시판</a>
                        <a class="collapse-item" href="noticeboard">공지게시판</a>
                    </div>
                </div>
            </li>


            <li class="nav-item active">
                <a class="nav-link" href="/admin/member">
                   <i class="fa-solid fa-user"></i>
                    <span>회원 관리</span></a>
            </li>

            <li class="nav-item active">
                <a class="nav-link" href="/admin/adminProduct">
                 <i class="fa-solid fa-box"></i>
                    <span>물품 관리</span></a>
            </li>



            <!-- Divider -->
            <hr class="sidebar-divider">

        </ul>
 