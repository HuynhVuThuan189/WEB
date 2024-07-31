using AspNetCoreHero.ToastNotification.Abstractions;
using doan.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace doan.Controllers
{
    public class GioHangController: Controller
    {
        private readonly StoreContext _context;
        public INotyfService _notyfyService { get; set; }
        public GioHangController(StoreContext context, INotyfService notifyService)
        {
            _context = context;
            _notyfyService = notifyService;
        }
        // Xu ly Gio hang voi Cookie
        public IActionResult Index_GioHang()
        {
            if (Request.Cookies["thongbaoloigiohang"] != null)
            {
                ViewData["thongbaoloigiohang"] = "Giỏ hàng không có sản phẩm";
            }
            Response.Cookies.Delete("thongbaoloigiohang");
            StoreContext context = HttpContext.RequestServices.GetService(typeof(doan.Models.StoreContext)) as StoreContext;
            if (Request.Cookies["GioHang"] != null)
            {
                var cart = Request.Cookies["GioHang"];
                List<GioHang> dataCart = JsonConvert.DeserializeObject<List<GioHang>>(cart);
                if (dataCart.Count > 0)
                {
                    
                    for (int i = 0; i < dataCart.Count; i++)
                    {
                        Sanpham dataSPnew = context.Product_id(dataCart[i].sanpham.MaSp);
                        if (dataSPnew.SoLuong <= 0)
                        {
                            _notyfyService.Error("Sản phẩm "+dataCart[i].sanpham.TenSp+" đã hết hàng.");
                            dataCart.RemoveAt(i);
                            i--;
                        }
                        else
                        {
                            if (dataSPnew.SoLuong < dataCart[i].Soluong)
                            {
                                _notyfyService.Success("Sản phẩm " + dataCart[i].sanpham.TenSp + " đã cập nhật lại số lượng.");
                                dataCart[i].Soluong = dataSPnew.SoLuong;
                            }
                        }
                        
                    }
                    if (dataCart.Count > 0)
                    {
                        Response.Cookies.Delete("GioHang");
                        CookieOptions option = new CookieOptions();
                        option.Expires = DateTime.Now.AddDays(30);
                        Response.Cookies.Append("GioHang", JsonConvert.SerializeObject(dataCart), option);
                        ViewBag.carts = dataCart;
                    }
                    else
                    {
                        Response.Cookies.Delete("GioHang");
                    }
                }
            }
            return View();
        }
        [HttpPost]
        public IActionResult Add_cart(int product_id)
        {
            StoreContext context = HttpContext.RequestServices.GetService(typeof(doan.Models.StoreContext)) as StoreContext;

            if (Request.Cookies["GioHang"] == null)
            {
                var product = context.Product_id(product_id);
                if (product.SoLuong <= 0)
                {
                    _notyfyService.Error("Sản phẩm đã hết hàng.");
                    return Redirect("/Giohang/Index_GioHang");
                }
                // Lấy liên kết hình ảnh sản phẩm
                var ha = context.HinhAnhSP(product_id).FirstOrDefault()?.LinkHinhAnh;

                List<GioHang> listCart = new List<GioHang>()
        {
            new GioHang
            {
                sanpham = product,
                hinhanh = ha, // Sử dụng liên kết hình ảnh
                Soluong = 1
            }
        };

                CookieOptions option = new CookieOptions();
                option.Expires = DateTime.Now.AddDays(30);
                Response.Cookies.Append("GioHang", JsonConvert.SerializeObject(listCart), option);
            }
            else
            {
                var cart = Request.Cookies["GioHang"];
                List<GioHang> dataCart = JsonConvert.DeserializeObject<List<GioHang>>(cart);
                bool check = true;
                for (int i = 0; i < dataCart.Count; i++)
                {
                    if (dataCart[i].sanpham.MaSp == product_id)
                    {
                        if (dataCart[i].sanpham.SoLuong == dataCart[i].Soluong)
                        {
                            _notyfyService.Error("Sản phẩm đã đạt số lượng tối đa.");
                            return Redirect("/Giohang/Index_GioHang");
                        }
                        dataCart[i].Soluong++;
                        check = false;
                    }
                }
                if (check)
                {
                    var product = context.Product_id(product_id);
                    if (product.SoLuong <= 0)
                    {
                        _notyfyService.Error("Sản phẩm đã hết hàng.");
                        return Redirect("/Giohang/Index_GioHang");
                    }
                    // Lấy liên kết hình ảnh sản phẩm
                    var ha = context.HinhAnhSP(product_id).FirstOrDefault()?.LinkHinhAnh;
                    dataCart.Add(new GioHang
                    {
                        sanpham = product,
                        hinhanh = ha, // Sử dụng liên kết hình ảnh
                        Soluong = 1
                    });
                }

                CookieOptions option = new CookieOptions();
                option.Expires = DateTime.Now.AddDays(30);
                Response.Cookies.Append("GioHang", JsonConvert.SerializeObject(dataCart), option);
            }
            _notyfyService.Success("Thêm thành công.");

            return Redirect("/Giohang/Index_GioHang");
        }

        [HttpPost]
        public IActionResult Delete_cart(int product_id)
        {
            StoreContext context = HttpContext.RequestServices.GetService(typeof(doan.Models.StoreContext)) as StoreContext;
            var cart = Request.Cookies["GioHang"];
            if (cart != null)
            {
                List<GioHang> dataCart = JsonConvert.DeserializeObject<List<GioHang>>(cart);
                
                dataCart.RemoveAll(item => item.sanpham.MaSp == product_id);
                CookieOptions option = new CookieOptions();
                option.Expires = DateTime.Now.AddDays(30);
                Response.Cookies.Append("GioHang", JsonConvert.SerializeObject(dataCart), option);

            }
            _notyfyService.Success("Xóa thành công.");
            return Redirect("/Giohang/Index_GioHang");
        }
        [HttpPost]
        public IActionResult Minus_quantity(int product_id, int sl)
        {
            StoreContext context = HttpContext.RequestServices.GetService(typeof(doan.Models.StoreContext)) as StoreContext;
            var cart = Request.Cookies["GioHang"];
            if (cart != null)
            {
                List<GioHang> dataCart = JsonConvert.DeserializeObject<List<GioHang>>(cart);
                for (int i = 0; i < dataCart.Count; i++)
                {
                    if (dataCart[i].sanpham.MaSp == product_id)
                    {
                        if (sl<=1) dataCart.RemoveAt(i); 
                        else dataCart[i].Soluong = sl-1;
                    }
                }
                CookieOptions option = new CookieOptions();
                option.Expires = DateTime.Now.AddDays(30);
                Response.Cookies.Append("GioHang", JsonConvert.SerializeObject(dataCart), option);

            }
            return Redirect("/Giohang/Index_GioHang");
        }
        [HttpPost]
        public IActionResult Plus_quantity(int product_id, int sl)
        {
            StoreContext context = HttpContext.RequestServices.GetService(typeof(doan.Models.StoreContext)) as StoreContext;
            var cart = Request.Cookies["GioHang"];
            if (cart != null)
            {
                List<GioHang> dataCart = JsonConvert.DeserializeObject<List<GioHang>>(cart);
                for (int i = 0; i < dataCart.Count; i++)
                {
                    if (dataCart[i].sanpham.MaSp == product_id)
                    {
                        var datanew = context.Product_id(dataCart[i].sanpham.MaSp);
                        if (datanew.SoLuong == dataCart[i].Soluong)
                        {
                            _notyfyService.Error("Sản phẩm đã đạt số lượng tối đa.");
                            return Redirect("/Giohang/Index_GioHang");
                        }
                        else
                        {
                            dataCart[i].Soluong = sl + 1;
                        }                        
                    }
                }
                CookieOptions option = new CookieOptions();
                option.Expires = DateTime.Now.AddDays(30);
                Response.Cookies.Append("GioHang", JsonConvert.SerializeObject(dataCart), option);

            }
            
            return Redirect("/Giohang/Index_GioHang");
        }


    }
}
