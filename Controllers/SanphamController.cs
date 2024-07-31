using doan.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PagedList.Core;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Net;

namespace doan.Controllers
{
    public class SanphamController : Controller
    {
        private readonly FivemenCoffeeContext _context;
        public SanphamController(FivemenCoffeeContext context)
        {
            _context = context;
        }
        public IActionResult Index(int? page)
        {
            try
            {
                var pageNumber = page == null || page <= 0 ? 1 : page.Value;
                var pageSize = 21;
                var IsSanphams = _context.Sanpham
                    .Include(s => s.Hinhanh) // Đảm bảo rằng danh sách hình ảnh liên quan được nạp
                    .AsNoTracking()
                    .OrderBy(x => x.MaSp);
                PagedList<doan.Models.Sanpham> models = new PagedList<doan.Models.Sanpham>(IsSanphams, pageNumber, pageSize);
                ViewBag.CurrentPage = pageNumber;
                return View(models);
            }
            catch
            {
                return RedirectToAction("Index", "Home");
            }


        }


        public IActionResult List(int id, int page = 1)
        {
            try
            {
                var pageSize = 9;

                // Tìm danh mục cụ thể (Danhmucsp) dựa trên id
                var danhmuc = _context.Danhmucsp.Find(id);

                if (danhmuc == null)
                {
                    // Nếu danh mục không tồn tại, có thể chuyển hướng hoặc xử lý khác tùy thuộc vào yêu cầu của bạn
                    return RedirectToAction("Index", "Home");
                }

                // Lọc sản phẩm theo danh mục
                var IsSanphams = _context.Sanpham
                    .Include(s => s.Hinhanh)
                    .Where(x => x.MaDanhMuc == danhmuc.MaDanhMuc)
                    .AsNoTracking()
                    .OrderBy(x => x.MaSp);

                // Tạo danh sách sản phẩm được phân trang
                PagedList<doan.Models.Sanpham> models = new PagedList<doan.Models.Sanpham>(IsSanphams, page, pageSize);

                // Đặt các thuộc tính ViewBag cho trang và danh mục hiện tại
                ViewBag.CurrentPage = page;
                ViewBag.CurrentCat = danhmuc;

                // Trả về view với danh sách sản phẩm được phân trang
                return View(models);
            }
            catch
            {
                // Xử lý ngoại lệ, chẳng hạn chuyển hướng đến trang chủ
                return RedirectToAction("Index", "Home");
            }
        }

        [Route("/{id}.html")]

        public IActionResult Details(int id)
        {
            try
            {
                var sanpham = _context.Sanpham
                    .Include(x => x.MaDanhMucNavigation)
                    .FirstOrDefault(x => x.MaSp == id);

                if (sanpham == null)
                {
                    return RedirectToAction("Index");
                }

                var isSanphams = _context.Sanpham
                    .Include(s => s.Hinhanh)
                    .AsNoTracking()
                    .Where(x => x.MaDanhMuc == sanpham.MaDanhMuc && x.MaSp == id)
                    .OrderBy(x => x.MaSp)
                    .ToList();

                var lsProduct = _context.Sanpham
                    .Include(s => s.Hinhanh)
                    .AsNoTracking()
                    .Where(x => x.MaDanhMuc == sanpham.MaDanhMuc && x.MaSp != id)
                    .OrderBy(x => x.MaSp)
                    .Take(4)
                    .ToList();

                ViewBag.Sanpham = lsProduct;
                ViewBag.Hinhanh = isSanphams; // Lưu danh sách sản phẩm với hình ảnh vào ViewBag
                return View(sanpham);
            }
            catch
            {
                return RedirectToAction("Index", "Home");
            }
        }
    }
}
